# Be sure to restart your server when you modify this file.
host = ENV["REDIS_HOST"]
port = ENV["REDIS_PORT"]&.to_i || 6379
db = ENV["REDIS_DB"]&.to_i || %w[production stage development test].index(Rails.env) || 15

Rails.application.config.session_store :redis_store, servers: { host: host,
                                                                port: port,
                                                                db: db,
                                                                expires_in: 90.minutes }
