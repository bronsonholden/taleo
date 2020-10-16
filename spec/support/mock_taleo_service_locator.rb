# frozen_string_literal: true

require 'json'
require 'sinatra/base'

# Service locator mock server
class MockTaleoServiceLocator < Sinatra::Base
  get '/:org_code' do
    content_type :json
    status 200
    {
      'response' => {
        'URL' => 'https://api.tbe.taleo.net'
      },
      'status' => {
        'success' => true,
        'detail' => {}
      }
    }.to_json
  end
end
