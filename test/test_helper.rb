ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "vcr"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


VCR.configure do |c|
  c.cassette_library_dir = "spec/support/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
end