
require 'sinatra'
require 'haml'
require 'json'

set :haml, :format => :html5
set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  haml :index
end

get '/display1/v' do
  content_type :json
  sleep(10)
  {:value => "88.88"}.to_json
end