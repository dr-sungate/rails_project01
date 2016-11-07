ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test/unit/rails/test_help'

require "simplecov"
require 'simplecov-rcov'



SimpleCov.start "rails"
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
