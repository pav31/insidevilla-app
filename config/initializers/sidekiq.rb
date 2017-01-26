require "sidekiq/middleware/i18n"

db = ENV["REDIS_DB"]&.to_i || %w[production stage development test].index(Rails.env) || 15
url = "redis://#{Redis.current.client.host}:#{Redis.current.client.port}/#{db}"

Sidekiq.configure_server do |config|
  config.redis = { url: url, namespace: "Sidekiq" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url, namespace: "Sidekiq" }
end