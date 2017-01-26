class Feedback < ActiveRecord::Base
  belongs_to :estate, inverse_of: :feedbacks

  has_attached_file :photo, styles: { main: "212x212#", thumb: "100x100#" }

  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/},
                                               size: {in: 0..3.megabytes }

  validates_presence_of :author, :email, :city, :occupation, :body, :estate, :photo
  validates :body, length: { maximum: Settings.feedback_length, too_long: I18n.t("flash.errors.too_long") }

  with_options unless: :system_email? do
    validates_uniqueness_of :email, scope: :estate_id
    validates :email, email: true
    after_create :send_email_notifications
  end

  scope :approved, -> { where(approved: true) }
  scope :landing_page, -> { includes(:estate).approved.where(favorite: true) }

  def approved_to_s?
    res = approved? ? :approved : :not_approved
    I18n.t(res)
  end

  def approve!
    update(approved: true)
  end

  def disapprove!
    update(approved: false)
  end

  private

  def send_email_notifications
    InfoMailer.feedback_created_system(id).deliver_later
    InfoMailer.feedback_created_client(id).deliver_later
  end
end
