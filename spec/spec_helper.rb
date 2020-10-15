require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'taleo'
require 'webmock/rspec'
require 'support/mock_taleo_service_locator'
require 'support/mock_taleo'

WebMock.disable_net_connect!(allow_localhost: true)

module SharedContext
  extend RSpec::SharedContext

  let(:org_code) { 'MOCKACCOUNT' }
  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:service_url) { 'https://sl.tbe.taleo.net' }
  let(:client) {
    Taleo::Client.new(org_code, username, password, service_url)
  }
  let(:client!) {
    client.login
    client
  }
end

RSpec.configure do |config|
  config.include SharedContext

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    stub_request(:any, /sl\.tbe\.taleo\.net/).to_rack(MockTaleoServiceLocator)
    stub_request(:any, /api\.tbe\.taleo\.net/).to_rack(MockTaleo)
  end
end
