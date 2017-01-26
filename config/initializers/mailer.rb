ActionMailer::Base.smtp_settings = {
    address: ENV['AWS_SES_ADDRESS'],
    port: 587,
    user_name: ENV['AWS_SES_SMTP_USERNAME'],
    password: ENV['AWS_SES_SMTP_PASSWORD'],
    domain: ENV['HOSTNAME'],
    authentication: :login,
    enable_starttls_auto: true
}