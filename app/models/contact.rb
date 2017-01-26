class Contact < MailForm::Base
  # template path: /
  attribute :name, validate: true
  attribute :user_email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone_number, validate: /\A\+?\d{7,14}\z/, allow_blank: true
  attribute :message, length: { in: 8..455 }, allow_blank: false
  attribute :nickname, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method in ActionMailer accepts.
  def headers
    {
      subject: Settings.contact_form_subject || 'Message from insidevilla.com contact form ',
      to: Settings.system_email_to || ENV['ADMIN_EMAIL'],
      from: %("#{ENV['SITE_TITLE']}" <#{Settings.no_reply_email}>)
    }
  end
end
