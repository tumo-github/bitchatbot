require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

# Load Models
Dir["./app/models/*.rb"].each{|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base

  get '/' do
    'Hello world!'
  end

  post '/webhook' do
    request.body.rewind
    result = JSON.parse(request.body.read)['queryResult']

p "### result"
p result

    if result['contexts'].present?
      response = InterpretService.perform(result['action'], result['contexts'][0]['parameters'])
    else
      response = InterpretService.perform(result['action'], result['parameters'])
    end

p "### response"
p response
    content_type :json, charset: 'utf-8'
    {
      'fulfillmentText': response,
      'payload': {
        'telegram': {
          'text':       response,
          'parse_mode': 'Markdown'
        }
      }
    }.to_json
  end

end
