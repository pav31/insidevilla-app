class Booking < ActiveRecord::Base
  include ActsAsEnum

  default_scope { order(:move_in_at) }

  BOOKING_STATUSES = %w[pending approved completed canceled unavailable]

  acts_as_enum status: BOOKING_STATUSES

  belongs_to :estate, inverse_of: :bookings

  before_validation :validate_status_approval

  validates_presence_of :move_in_at, :move_out_at, :status
  validates :comment, length: { maximum: 700, too_long: I18n.t("flash.errors.too_long") }
  validates :status, inclusion: BOOKING_STATUSES

  with_options unless: -> { self.unavailable? } do
    validates_presence_of :name, :email, :phone_number, :adults, :kids
    validate :validate_move_out_at, if: -> { approved? || new_record? }
    validate :validate_move_in_at, if: -> { new_record? }
    validates :email, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }
    after_save :send_email_notifications
  end

  scope :booked, ->(start, finish = start) { ransack(move_in_at_gteq: start, move_out_at_lteq: finish).result }
  scope :move_in_overlap, -> (estate_id, date) { approved.ransack(estate_id_eq: estate_id, move_in_at_lteq: date, move_out_at_gt: date) }
  scope :move_out_overlap, -> (estate_id, date) { approved.ransack(estate_id_eq: estate_id, move_in_at_lt: date, move_out_at_gteq: date) }

  alias approve! approved!

  def start_time
    move_in_at
  end

  def booked_css_class(date)
    start, finish = [move_in_at, move_out_at]
    stat = status[0..3]
    case date
      when start then "move-in -#{stat}"
      when finish then "move-out #{stat}-"
      when start..finish then "booked #{stat}"
      else return ''
    end
  end

  private

  def send_email_notifications
    if id_changed?(from: nil)
      InfoMailer.booking_created_system(id).deliver_later
      InfoMailer.booking_created_client(id).deliver_later
    end
    if status_changed?(to: 'approved')
      InfoMailer.booking_approved_client(id).deliver_later
    end
  end

  def validate_move_in_at
    if move_in_at? && move_in_at < Date.current
      errors.add(:move_in_at, I18n.t('errors.message.move_in_at'))
    end
  end

  def validate_move_out_at
    if move_in_at? && move_out_at? &&  move_out_at <= move_in_at
      errors.add(:move_out_at, I18n.t('errors.message.move_out_at'))
    end
  end

  def validate_status_approval
    if Booking.where.not(id: id).move_in_overlap(estate_id, move_in_at).result.any?
      errors.add(:move_in_at, I18n.t('errors.message.date_not_available'))
    elsif Booking.where.not(id: id).move_out_overlap(estate_id, move_out_at).result.any?
      errors.add(:move_out_at, I18n.t('errors.message.date_not_available'))
    end
  end
end
