require 'eventmachine'
require 'faye'

EM.run do
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

end