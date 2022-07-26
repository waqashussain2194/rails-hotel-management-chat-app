module Api
  module V1
    class GuestsController < BaseController
      def index
        collection = GuestsCollection.new collection_params
        render json: collection.results
      end

      private

      def collection_params
        params.merge(hotel_id: current_hotel.id)
      end
    end
  end
end
