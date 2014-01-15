require 'eventmachine'
require 'faye'
require 'thin'
require './HydraGUI'

EM.run do
  server  = 'thin'
  host    = '0.0.0.0'
  port    = ENV['PORT'] || '4567'
  web_app = HydraGUI::Hydra.new

  Signal.trap("INT")  { EventMachine.stop }
  Signal.trap("TERM") { EventMachine.stop }

  client = Faye::Client.new('http://localhost:3000/faye')
  count = 0.0

  EM.add_periodic_timer(10) do
    count += 1.00
    publication = client.publish('/display1', 'v' => count.to_s)

    publication.callback do
      puts 'Message received by server!'
    end

    publication.errback do |error|
      puts 'There was a problem: ' + error.message
    end
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