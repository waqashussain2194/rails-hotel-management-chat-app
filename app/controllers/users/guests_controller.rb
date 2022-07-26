module Users
  class GuestsController < BaseController
    def index
      render react_component: 'UsersGuestsIndex'
    end

    def show
      render react_component: 'UsersGuestsShow', props: { guest_id: params[:id] }
    end
  end
end
