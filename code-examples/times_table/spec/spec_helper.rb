# SimpleCov
require "simplecov"
SimpleCov.start do
  # don't track coverage of tests!
  add_filter "/spec/"

  # don't track core application files
  add_filter "/app.rb"
  add_filter "/db/db.rb"
  add_filter "/helpers/helpers.rb"
end
SimpleCov.coverage_dir "#{__dir__}/_coverage"

# Sinatra App
ENV["APP_ENV"] = "test"
require_relative "../app"
def app
  Sinatra::Application
end

# Capybara
require "capybara/rspec"
Capybara.app = Sinatra::Application

# RSpec
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods

  # before each test is run, delete all records in the Player table
  config.before do
    spec_before
  end
end

# Spec functions
require_relative "spec_functions"
