require 'bunny'

class PublisherService
  def self.publish(message)
    connection = Bunny.new(hostname: ENV.fetch("RABBITMQ_HOST", "localhost"))
    connection.start
    channel = connection.create_channel
    exchange = channel.fanout("coliseum.events")
    exchange.publish(message.to_json)
    connection.close
  end
end