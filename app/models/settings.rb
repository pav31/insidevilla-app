# RailsSettings Model
class Settings < RailsSettings::CachedSettings
  defaults[:viber] = '+66944122750'
  defaults[:whatsapp] = '+66620581494'
  defaults[:price_margin] = 0.3
  defaults[:latitude] = 7.9519
  defaults[:longitude] = 98.3381
  defaults[:map_offset] = 0.002
  defaults[:calendar_number_of_months] = 6
  defaults[:system_email_feedback] = ENV['SYSTEM_EMAIL_FEEDBACK']
  defaults[:feedback_length] = 1500
  defaults[:system_email_from] = ENV['SYSTEM_EMAIL_FROM']
  defaults[:system_email_to] = ENV['SYSTEM_EMAIL_TO']
  defaults[:no_reply_email] = ENV['NO_REPLY_EMAIL']
  defaults[:contact_form_subject] = "New request for #{ENV['SITE_TITLE']}"
  defaults[:vk_url] = ENV['VK_URL']
  defaults[:facebook_url] = ENV['FACEBOOK_URL']
  defaults[:instagram_url] = ENV['INSTAGRAM_URL']
  defaults[:youtube_url] = ENV['YOUTUBE_URL']

  class << self
    def price_margin
      super.to_f
    end

    def latitude
      super.to_f
    end

    def longitude
      super.to_f
    end

    def map_offset
      super.to_f
    end

    def calendar_number_of_months
      super.to_i
    end
  end
end
