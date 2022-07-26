module Guests
  class CreateFromSmooch
    include Service
    attr_reader :hotel, :params

    def initialize(hotel, params)
      @hotel = hotel
      @params = params
    end

    def call
      with_transaction do
        Guest.create!(guest_params).tap do |g|
          g.check_ins.create!(hotel: hotel)
        end
      end
    end

    private

    def guest_params
      {}.tap do |h|
        h[:external_id] = external_id
        h[:profile] = { name: name || external_id }
      end
    end

    def external_id
      @external_id ||= params.dig('appUser', '_id')
    end

    def name
      @name ||= params.dig('appUser').dig('devices').first.dig('displayName')
    end
  end
end
