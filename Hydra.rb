require 'thin'
require 'eventmachine'
require './HydraGUI'

EM.run do
  server  = 'thin'
  host    = '0.0.0.0'
  port    = ENV['PORT'] || '4567'
  web_app = HydraGUI::Hydra.new

  # Start some background tasks here...

  EM.add_periodic_timer(1200) do
    # Do a repeating task here...
  end

  dispatch = Rack::Builder.app do
    map '/' do
      run web_app
    end
  end

  Rack::Server.start({
      :app    => dispatch,
      :server => server,
      :Host   => host,
      :Port   => port
  })
end