class Estate < ActiveRecord::Base
  include EstateConstants
  include ActsAsEnum
  paginates_per 15

  acts_as_enum tenure_type: TENURE_TYPES,
               estate_type: ESTATE_TYPES,
               estate_class: ESTATE_CLASSES,
               place: PLACES,
               region: REGIONS,
               cleaning_period: CLEANING_PERIODS

  monetize :price_cents
  monetize :price_day_low_cents
  monetize :price_day_high_cents
  monetize :price_day_pick_cents
  monetize :price_week_low_cents
  monetize :price_week_high_cents
  monetize :price_week_pick_cents
  monetize :price_month_low_cents
  monetize :price_month_high_cents
  monetize :price_month_pick_cents
  monetize :admin_price_cents
  monetize :admin_price_day_low_cents
  monetize :admin_price_day_high_cents
  monetize :admin_price_day_pick_cents
  monetize :admin_price_week_low_cents
  monetize :admin_price_week_high_cents
  monetize :admin_price_week_pick_cents
  monetize :admin_price_month_low_cents
  monetize :admin_price_month_high_cents
  monetize :admin_price_month_pick_cents

  translates :title, :description
  has_many :estate_comforts
  has_many :comforts, through: :estate_comforts
  has_many :images, as: :imageable, dependent: :destroy, autosave: true
  has_many :feedbacks, dependent: :destroy, inverse_of: :estate
  has_many :bookings, dependent: :destroy, inverse_of: :estate

  accepts_nested_attributes_for :images, reject_if: :reject_images, allow_destroy: true
  accepts_nested_attributes_for :feedbacks
  has_attached_file :main_image,
                    styles: {
                        estate_wide: "570x320#", estate_square: "370x320#", # index page
                        main_large: "628x329#", main_small: "628x329#",
                        thumb: "100x100#"
                     },
                     convert_options: {
                       thumb: "-quality 75 -strip",
                       gallery_small: "-quality 75 -strip"
                     }

  has_attached_file :slider, styles: { large: "2100x792#", thumb: "100x100#" }

  validates_attachment :main_image, :slider, content_type: { content_type: /\Aimage\/.*\Z/ },
                       size: { in: 0..10.megabytes }

  validates :price_day_low_cents, :price_month_low_cents,
            presence: true, numericality: true
  validates_presence_of :title_translations, :address, :slider, :main_image, :tenure_type, :estate_type, :region, :place

  validates :tenure_type, inclusion: TENURE_TYPES
  validates :estate_type, inclusion: ESTATE_TYPES
  validates :estate_class, inclusion: ESTATE_CLASSES
  validates :place, inclusion: PLACES
  validates :region, inclusion: REGIONS
  validates :cleaning_period, inclusion: CLEANING_PERIODS, allow_blank: true

  before_validation :serialize_columns

  geocoded_by :address
  after_validation :geocode # auto-fetch coordinates

  scope :with_locale, ->(locale) { where("title_translations -> '#{locale}' != ''")  }
  scope :with_comforts, ->(ids) { joins(:comforts).where(comforts: {id: ids}) } #wrong query
  scope :featured, ->(limit) { where(featured: true).limit(limit) }
  scope :bathrooms_num, ->(num) { where(bathrooms: num) }
  scope :bedrooms_num, ->(num) { where(bedrooms: num) }
  scope :distance_between, ->(min, max) { where('sea_distance BETWEEN ? AND ?', min, max) }
  scope :under_one, -> { distance_between(0, 1000) }
  scope :one_three, -> { distance_between(1000, 3000) }
  scope :three_five, -> { distance_between(3000, 5000) }

  # Similar estates are:
  # 1. same number of bedrooms
  # 2. price range +/-30%
  def similar(limit = 3)
    margin = price_month_low_cents * Settings.price_margin
    low = price_month_low_cents - margin
    high = price_month_low_cents + margin
    Estate.where("bedrooms = ? AND price_month_low_cents BETWEEN ? AND ?", bedrooms, low, high).limit(limit)
  end

  def price_select(period, season)
    send("price_#{period}_#{season}")
  end

  def add_comfort(id)
    comforts << Comfort.find_by_id(id)
    save
  end

  def bookings_within_dates(start, finish)
    bookings.where('(move_in_at BETWEEN ? AND ?) OR (move_out_at BETWEEN ? AND ?)', start, finish, start, finish)
  end

  def booked(date)
    case date
      when bookings
    end
    start = Time.now
    finish = start + 365.days
    (start..finish).map do |date|
      date == bookings.booked
    end
  end

  def sea_distance_to_s
    if closest_beach && sea_distance
      "#{I18n.t(:sea_distance)} #{closest_beach} #{helpers.number_to_human(sea_distance, units: :distance)}"
    elsif sea_distance
      "#{I18n.t(:sea_distance)} #{helpers.number_to_human(sea_distance, units: :distance)}"
    elsif closest_beach
      "#{I18n.t(:closest_beach)} #{closest_beach}"
    end
  end

  def serialize_columns
    if cleaning_period.blank?
      self.cleaning_period = nil
    end
  end

  def helpers
    ActionController::Base.helpers
  end

  private

  def reject_images(attributes)
    attributes['attachment'].blank?
  end
end
