module Api
  class BaseController < ActionController::API
    before_action :authenticate_user!

    protected

    def current_hotel
      @hotel ||= current_user.hotel
    end
  end
end
