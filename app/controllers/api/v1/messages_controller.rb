module Api
  module V1
    class MessagesController < BaseController
      def index
        collection = MessagesCollection.new collection_params
        render json: collection.results
      end

      def create
        Message.create!(message_params).tap do |msg|
          CallServiceJob.perform_later 'Smooch::SendMessage', msg
          render json: msg
        end
      end

      private

      def collection_params
        params.require(:guest_id)
        params.merge(hotel_id: current_hotel.id)
      end

      def message_params
        params
          .require(:message)
          .permit(:content, :guest_id)
          .merge(
            hotel_id: current_hotel.id,
            user_id: current_user.id
          )
      end
    end
  end
end
