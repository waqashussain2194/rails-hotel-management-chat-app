module Webhooks
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :verify_token!

    protected

    def verify_token!
      return if params[:token] == ENV.fetch('WEBHOOK_TOKEN')

      render json: false, status: :unauthorized
    end

    def current_hotel
      @current_hotel ||= Hotel.find_by!(external_id: params.dig('app', '_id'))
      #Hotel.first
    end

    def current_guest
      @current_guest ||= begin
        Guest.find_by(external_id: guest_id) || Guests::CreateFromSmooch.call(current_hotel, params)
        #Guest.first
      end
    end

    def guest_id
      @guest_id ||= params.dig('appUser', '_id')
    end
  end
end
