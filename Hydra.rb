require 'thin'
require 'eventmachine'
require './HydraGUI'

EM.run do
  server  = 'thin'
  host    = '0.0.0.0'
  port    = ENV['PORT'] || '4567'
  web_app = HydraGUI::Hydra.new

  count = 0
  # Start some background tasks here...

  EM.add_periodic_timer(10) do
    count += 1
    puts "hi #{count}"
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