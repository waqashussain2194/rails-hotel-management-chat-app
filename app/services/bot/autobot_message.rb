module Bot
  class AutobotMessage < Base
     attr_reader :hotel, :guest, :message

    def initialize(hotel, guest, message)
      @guest = guest
      @message = message
      @hotel = hotel
    end

    def call
      response = client.text_request message

      res = response.as_json

      if res['result']['action'] == 'input.unknown'
        Notification.create!(notification_params('Reply to this Message : ' + message))
      else
        msg = Message.create!(message_params(res['result']['fulfillment']['speech']))
        Smooch::SendMessage.call(msg)
        return msg
      end
    end

    private

    def client
      @client ||= ApiAiRuby::Client.new(
        client_access_token: ENV.fetch('DIGITAL_FLOW_TOKEN'),
        api_lang: 'en',
        api_base_url: ENV.fetch('DIGITAL_FLOW_URL'),
        api_version: 'v1',
        api_session_id: ENV.fetch('DIGITAL_FLOW_SESSION_ID')
      )
    end
    def message_params(msg)
      {}.tap do |h|
        h[:content] = msg
        h[:is_agent] = true
        h[:guest_id] = guest.id
        h[:hotel_id] = hotel.id
      end
    end

    def notification_params(notif)
      {}.tap do |h|
        h[:content] = notif
        h[:guest_id] = guest.id
        h[:hotel_id] = hotel.id
      end
    end
  end
end
