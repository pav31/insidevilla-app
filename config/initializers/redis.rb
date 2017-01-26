host = ENV["REDIS_HOST"]
port = ENV["REDIS_PORT"]&.to_i || 6379
db = ENV["REDIS_DB"]&.to_i || %w[production stage development test].index(Rails.env) || 15

Redis.current = Redis.new(host: host, port: port, db: db)
