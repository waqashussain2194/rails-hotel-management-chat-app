module Smooch
  class ReceiveMessage < Base
    attr_reader :hotel, :guest, :message_params

    def initialize(hotel, guest, message_params)
      @hotel = hotel
      @guest = guest
      @message_params = message_params
    end

    def call
      Message.create!(message_params.merge(hotel: hotel, guest: guest))
    end
  end
end
