require 'rails_helper'

RSpec.describe 'Guests', type: :request do
  let(:hotel) { create(:hotel) }
  let(:user) { create(:user, hotel: hotel) }
  let(:guests) { create_list(:guest, 15) }
  before do
    sign_in(user)
    guests.each_with_index do |g, i|
      g.check_ins.create!(hotel: hotel) if i > 4
      g.check_ins.update_all(checked_out_at: Time.current) if i > 9
    end
  end

  describe 'GET /api/v1/guests' do
    context 'filter: unfiltered' do
      before { get '/api/v1/guests' }
      it 'returns list of all guests with current_user\'s hotel' do
        expect(response).to be_success
        expect(json['guests'].size).to eq(10)
        expect(json['guests'][0]).to include('id', 'initials', 'profile')
      end
    end

    context 'filter: checked in' do
      before { get '/api/v1/guests', params: { checked_in: true } }
      it 'returns list of guests checked in with current_user\'s hotel' do
        expect(response).to be_success
        expect(json['guests'].size).to eq(5)
        expect(json['guests'][0]).to include('id', 'initials', 'profile')
      end
    end

    context 'filter: checked out' do
      before { get '/api/v1/guests', params: { checked_out: true } }
      it 'returns list of guests checked out with current_user\'s hotel' do
        expect(response).to be_success
        expect(json['guests'].size).to eq(5)
        expect(json['guests'][0]).to include('id', 'initials', 'profile')
      end
    end
  end
end
