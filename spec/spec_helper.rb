ENV['ENVIRONMENT'] = 'test'
ENV['ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '/controller.rb')
require 'sinatra/base'
require_relative './setup_test_database'
require 'capybara'
require 'capybara/rspec'
Capybara.app = MakersBnB
# Capybara.default_driver = :webkit
# Capybara.javascript_driver = :webkit

# Capybara.register_server("puma") do |app, port|
#   server = Puma::Server.new(app)
#   server.add_tcp_listener(Capybara.server_host, port)
#   server.run
# end

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

end
