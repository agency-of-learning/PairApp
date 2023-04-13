ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
# require_relative 'test_helpers/auth0_helper'
require_relative './test_helpers/auth0_helper'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include Auth0Helper

  # Add more helper methods to be used by all tests here...
end
OmniAuth.config.test_mode = true
OmniAuth.config.failure_raise_out_environments = []