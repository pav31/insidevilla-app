Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # ActionMailer Config
  config.action_mailer.preview_path = "#{Rails.root}/lib/mailers/previews"
  # Unlike controllers, the mailer instance doesn't have any context about the incoming request so
  # you'll need to provide the :host parameter yourself.
  config.action_mailer.default_url_options = { host: ENV['HOSTNAME'] }
  # Unlike controllers, the mailer instance doesn't have any context about the incoming request so
  # you'll need to provide the :asset_host parameter yourself.
  config.action_mailer.asset_host = 'http://' + ENV['HOSTNAME']
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  # Send email in development mode?
  config.action_mailer.perform_deliveries = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Bullet configuration. https://github.com/flyerhzm/bullet#configuration
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = false
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.growl = false
    # Send XMPP/Jabber notifications to the receiver indicated
    # Bullet.xmpp = { account: 'bullets_account@jabber.org',
    #                 password: 'bullets_password_for_jabber',
    #                 receiver: 'your_account@jabber.org',
    #                 show_online_status: true }
    Bullet.rails_logger = true
    Bullet.honeybadger = false
    Bullet.bugsnag = false
    Bullet.airbrake = false
    Bullet.rollbar = false
    Bullet.add_footer = true
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]
    # Bullet.slack = {}

    Bullet.add_whitelist type: :unused_eager_loading, class_name: "Estate", association: :estate_comforts
  end
end
