module Webhooks
  module Smooch
    class MessagesController < BaseController
      def create
        ::Smooch::ReceiveMessage.call(current_hotel, current_guest, message_params).tap do |m|
          Messages::Broadcast.call(m)
        end

        Bot::AutobotMessage.call(current_hotel, current_guest, message).tap do |m|
          "#{m.class.name.pluralize}::Broadcast".constantize.call(m)
        end

        render json: true
      end

      private

      def message_params
        {}.tap do |h|
          h[:content] = message
        end
      end

      def message
        # params[:message]
        params['messages'][0]['text']
      end
    end
  end
end
