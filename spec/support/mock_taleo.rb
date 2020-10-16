require 'json'
require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/streaming'

# Mock Taleo API server
class MockTaleo < Sinatra::Base
  register Sinatra::Namespace
  register Sinatra::Streaming

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
          'employee' => "#{url}/object/candidate/#{params[:id]}/employee",
          'resume' => "#{url}/object/candidate/#{params[:id]}/resume",
          'attachments' => "#{url}/object/candidate/#{params[:id]}/attachment"
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

  def mock_activity
    {
      'activity' => {
        'id' => 1,
        'activityDesc' => 'Activity',
        'activityEmployee' => 1,
        'relationshipUrls' => {
          'activityEmployee' => "#{url}/object/activity/#{params[:id]}/activityEmployee",
          'formDownloadUrl' => "#{url}/object/activity/#{params[:id]}/form/download"
        }
      }
    }
  end

  def mock_attachment(entity, id = 1)
    {
      'attachment' => {
        'id' => id,
        'contentType' => 'text/plain',
        'attachmentType' => 'User_Attachment_Type',
        'downloadUrl' => "#{url}/object/#{entity}/#{params[:id]}/attachment/#{id}/download"
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
      get '/search' do
        json_response 200, {
          'pagination' => {
            'total' => 5,
            'self' => "#{url}/object/employee/search"
          },
          'searchResults' => Array.new(5) { mock_employee }
        }
      end

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

    namespace '/activity' do
      namespace '/:id' do
        get {
          json_response 200, mock_activity
        }

        get '/activityEmployee' do
          json_response 200, mock_employee
        end

        get '/form/download' do
          stream do |out|
            out << 'Mock file contents'
          end
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

        get '/resume' do
          stream do |out|
            out << 'Mock resume contents'
          end
        end

        namespace '/attachment' do
          get {
            json_response 200, {
              'attachments' => Array.new(5) { |i| mock_attachment('candidate', i) }
            }
          }

          namespace '/:aid' do
            get {
              json_response 200, mock_attachment('candidate', params[:aid])
            }

            get '/download' do
              stream do |out|
                out << 'Mock attachment contents'
              end
            end
          end
        end
      end
    end
  end
end
