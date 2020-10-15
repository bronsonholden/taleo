require 'json'
require 'sinatra/base'

# Mock Taleo API server
class MockTaleo < Sinatra::Base
  attr_reader :url

  def initialize
    @url = 'https://api.tbe.taleo.net'
    super
  end

  def request_json
    request.body.rewind
    JSON.parse(request.body.read)
  end

  def json_response(status_code, data)
    content_type :json
    status status_code
    {
      'response' => data,
      'status' => {
        'success' => true,
        'detail' => {}
      }
    }.to_json
  end

  post '/login' do
    puts 'asdf'
    json_response 200, {
      'authToken' => 'webapi-12345'
    }
  end

  post '/logout' do
    json_response 200, {}
  end

  get '/object/employee/:id' do
    json_response 200, {
      'employee' => {
        'candidate' => 1,
        'employeeId' => params[:id].to_i,
        'ssn' => 123456789,
        'relationshipUrls' => {
          'candidate' => "#{url}/object/employee/#{params[:id]}/candidate",
          'packets' => "#{url}/object/employee/#{params[:id]}/packets"
        }
      }
    }
  end
end
