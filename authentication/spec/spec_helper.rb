ENV["RACK_ENV"] = 'test'
require File.join(File.dirname(__FILE__), '..', 'config/environment')
require 'rspec'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path('../support/**/*.rb"', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

Capybara.configure do |config|
  config.app = App
end
