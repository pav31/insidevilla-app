class StaticPage < ActiveRecord::Base
  include ExportData

  store_accessor :meta, :meta_title, :keywords, :description

  translates :title, :content
  extend FriendlyId
  friendly_id :title_en, use: [:slugged, :history]
  acts_as_list
  enum category: %i[main secondary service info legal about non_categorized]

  has_attached_file :image, styles: { full_size: "301x394#", thumb: "100x100" }

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { in: 0..5.megabytes }

  scope :with_locale, ->(locale) { where("title_translations -> '#{locale}' != ''")  }

  validates :title, presence: true
end
