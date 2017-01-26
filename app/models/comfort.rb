class Comfort < ActiveRecord::Base
  enum category: %i[main secondary]

  translates :name
  has_many :estate_comforts
  has_many :estates, through: :estate_comforts

  has_attached_file :icon, styles: { icon: "38x38>", mini: "20x20>" },
                           default_url: "/images/:style/missing.png"

  validates_attachment :icon, content_type: { content_type: 'image/png' },
                       size: { in: 0..1.megabytes }
  validates_presence_of :name
  validates_uniqueness_of :name_translations

  scope :with_locale, ->(locale) { where("name_translations -> '#{locale}' != ''")  }

  ransacker :name do |parent|
    Arel::Nodes::InfixOperation.new('->', parent.table[:name_translations], Arel::Nodes.build_quoted("#{I18n.locale}"))
  end
end
