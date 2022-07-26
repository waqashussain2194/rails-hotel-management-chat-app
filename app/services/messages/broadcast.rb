module Messages
  class Broadcast
    include Service
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def call
      payload = ActiveModelSerializers::SerializableResource.new(message).as_json
      ActionCable.server.broadcast "messages:#{message.hotel_id}", payload
    end
  end
end
