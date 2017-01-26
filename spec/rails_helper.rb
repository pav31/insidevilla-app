# The SimpleCov.start must be issued before any of your application code is required!
# https://github.com/colszowka/simplecov#getting-started
# Run "open coverage/index.html" in terminal to view coverage
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Если понадобится пересоздавать базу перед каждым прогоном, можно делать так:
#
#   SnapExit::Application.load_tasks
#   Rake::Task["db:setup"].invoke

ActiveRecord::Migration.maintain_test_schema!

require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

# Для тестового окружения Devise будет генерировать слабо-зашифрованные пароли,
# чтобы не тратить лишнее процессорное время на сложные алгоритмы шифрования
Devise.stretches = 1

# В тестах бессмысленно тратить процессорное время на логирование всех
# безошибочных запросов к серверу и базе данных
Rails.logger.level = Logger::WARN

# Небольшой хак для того, чтобы в тестовом окружении во всех тредах использовалось
# одно и то же подключение к базе данных, что позволит использовать нативные
# рельсовые транзакции для отката сделанных во время теста изменений в базе
# вместо тяжёлого DatabaseCleaner даже в тестах с Capybara
ActiveRecord::Base.connection.tap do |connection|
  ActiveRecord::Base.send(:define_singleton_method, :connection) { connection }
end

# Настраиваем RSpec
RSpec.configure do |config|
  config.order = :random
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end
