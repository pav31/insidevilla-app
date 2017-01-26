class EstateComfort < ActiveRecord::Base
  belongs_to :estate
  belongs_to :comfort

  validates_uniqueness_of :comfort_id, scope: :estate_id
end
