require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:hotel) { create(:hotel) }
  let(:user) { create(:user, hotel: hotel) }
  let(:guest_1) { create(:guest) }
  let(:guest_2) { create(:guest) }
  let!(:messages_1) { create_list(:message, 5, guest: guest_1, hotel: hotel) }
  let!(:messages_2) { create_list(:message, 5, guest: guest_2, hotel: hotel) }
  before do
    sign_in(user)
  end

  describe 'GET /api/v1/messages' do
    context 'guest 1 id is provided' do
      before { get '/api/v1/messages', params: { guest_id: guest_1.id } }
      it 'returns list of all messages for guest 1' do
        expect(response).to be_success
        expect(json['messages'].size).to eq(5)
        expect(json['messages'][0]).to include('id', 'content', 'guest', 'user')
      end
    end

    context 'no guest id is provided' do
      it 'raises raises param missing error' do
        expect { get '/api/v1/messages' }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
