# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('Rails is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'shoulda/matchers'
require 'factory_girl_rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'rake'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
Dir[DateBook::Engine.root.join('spec/support/*.rb')]
  .each { |f| require f }
Dir[DateBook::Engine.root.join('spec/support/**/*.rb')]
  .each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migrator.migrations_paths = 'spec/dummy/db/migrate'
ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 10

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Dummy::Application.load_tasks
    Rake::Task['db:seed'].invoke # loading seeds
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include Rails.application.routes.url_helpers

  # Capybara doesn't work on helpers
  config.include RSpecHtmlMatchers, type: :helper

  config.before :each, type: :helper do
    helper.class.include DateBook::Engine.routes.url_helpers
  end

  # In order to tell Rspec how to use Devise, as per
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-%28and-RSpec%29
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.include Warden::Test::Helpers

  config.before :suite do
    Warden.test_mode!
  end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.register_ordering(:global) do |items|
    items.sort_by do |item|
      case item.metadata[:folder]
      when :models then 10
      when :abilities then 20
      when :routing then 30
      when :controllers then 40
      when :helpers then 50
      when :features then 60
      when :requests then 70
      when :mailers then 80
      else 5
      end
    end
  end
end
