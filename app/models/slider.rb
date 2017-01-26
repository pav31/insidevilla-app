class Slider < ActiveRecord::Base
  default_scope { order(:priority) }

  translates :title, :text

  has_attached_file :image, styles: { large: "2100x", preview: "500x500#", thumb: "100x100#" }

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                       size: { in: 0..10.megabytes }

  scope :with_locale, ->(locale) { where("title_translations -> '#{locale}' != ''")  }
  scope :active, -> { where(active: true) }
end
