# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0.1'

# Add additional assets to the asset load path
Rails.application.config.assets.paths += %W[#{Rails.root}/app/assets]

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w[ckeditor/** vendor/modernizr.js fonts/** images/** javascripts/**  stylesheets/** *.png *.jpg *.jpeg *.svg *.eot *.woff *.ttf]
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

# Other options.
Rails.application.config.assets.initialize_on_precompile = false
Rails.application.config.assets.configure do |env|
  env.cache = ActiveSupport::Cache.lookup_store(:memory_store) if Rails.env.development? || Rails.env.test?
end