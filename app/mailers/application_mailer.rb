class ApplicationMailer < ActionMailer::Base
  default from: Settings.system_email_from
  layout 'mailer'
end
