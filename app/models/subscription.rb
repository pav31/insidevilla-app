class Subscription < ActiveRecord::Base
  validates :email, presence: true, allow_blank: false, uniqueness: { case_sensitive: false }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def eq_token?(other_token)
    token == other_token.to_s
  end

  def activate!
    update(active: true)
  end

  def deactivate!
    update(active: false)
  end
end
