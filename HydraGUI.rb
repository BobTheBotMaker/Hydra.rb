
require 'sinatra/base'
require 'haml'
require 'json'

module HydraGUI
  class Hydra < Sinatra::Base
    set :haml, :format => :html5
    set :public_folder, File.dirname(__FILE__) + '/public'
    enable :logging

    get '/' do
      haml :index
    end

  end
end
