module Api
  module V1
    class NotificationsController < BaseController
      def index
        collection = NotificationsCollection.new collection_params
        render json: collection.results
      end

      def destroy
        Notification.destroy(params[:id])
      end

      private

      def collection_params
        params.require(:guest_id)
        params.merge(hotel_id: current_hotel.id)
      end
    end
  end
end
