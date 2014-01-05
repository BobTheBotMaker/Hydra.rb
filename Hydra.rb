require 'sinatra'

set :haml, :format => :html5
set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  haml :index
end