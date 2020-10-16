require 'json'
require 'sinatra/base'
require 'sinatra/namespace'

# Mock Taleo API server
class MockTaleo < Sinatra::Base
  register Sinatra::Namespace

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

  def mock_employee
    {
      'employee' => {
        'candidate' => 1,
        'employeeId' => params[:id].to_i,
        'ssn' => 123456789,
        'relationshipUrls' => {
          'candidate' => "#{url}/object/employee/#{params[:id]}/candidate",
          'packets' => "#{url}/object/employee/#{params[:id]}/packet"
        }
      }
    }
  end

  def mock_candidate
    {
      'candidate' => {
        'employee' => 1,
        'candId' => 1,
        'firstName' => 'John',
        'lastName' => 'Doe',
        'relationshipUrls' => {
          'employee' => "#{url}/object/candidate/#{params[:id]}/employee"
        }
      }
    }
  end

  def mock_packet
    {
      'packet' => {
        'activitiesCompleted' => 10,
        'activitiesCount' => 10,
        'employeeId' => 1,
        'activityPacketId' => 1,
        'relationshipUrls' => {
          'employeeId' => "#{url}/object/packet/#{params[:id]}/employeeId"
        }
      }
    }
  end

  post '/login' do
    json_response 200, {
      'authToken' => 'webapi-12345'
    }
  end

  post '/logout' do
    json_response 200, {}
  end

  namespace '/object' do
    namespace '/employee' do
      namespace '/:id' do
        get {
          json_response 200, mock_employee
        }

        get '/candidate' do
          json_response 200, mock_candidate
        end

        get '/packet' do
          json_response 200, {
            'activityPackets' => Array.new(5) { mock_packet }
          }
        end
      end
    end

    namespace '/packet' do
      namespace '/:id' do
        get {
          json_response 200, mock_packet
        }

        get '/employeeId' do
          json_response 200, mock_employee
        end
      end
    end

    namespace '/candidate' do
      namespace '/:id' do
        get {
          json_response 200, mock_candidate
        }

        get '/employee' do
          json_response 200, mock_employee
        end
      end
    end
  end
end
