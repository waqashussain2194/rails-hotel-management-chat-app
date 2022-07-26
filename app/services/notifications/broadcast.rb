module Notifications
  class Broadcast
    include Service
    attr_reader :notification

    def initialize(notification)
      @notification = notification
    end

    def call
      payload = ActiveModelSerializers::SerializableResource.new(notification).as_json
      ActionCable.server.broadcast "notifications:#{notification.hotel_id}", payload
    end
  end
end
