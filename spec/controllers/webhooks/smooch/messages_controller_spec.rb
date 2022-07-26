require 'rails_helper'

RSpec.describe Webhooks::Smooch::MessagesController, type: :controller do
  describe 'POST #create' do
    context 'with invalid webhook token' do
      let(:params) { { token: 'INVALID_TOKEN' } }

      it 'returns 401 unauthorized' do
        post :create, params: params
        expect(response).to be_unauthorized
      end
    end

    context 'with valid webhook token' do
      let(:token_param) { { token: ENV.fetch('WEBHOOK_TOKEN') } }
      let(:webhook_params) { token_param.merge(app: { _id: 'non-existent' }, messages: [{ text: 'temp' }]) }

      context 'hotel exists' do
        let(:hotel) { create(:hotel) }
        let(:base_params) { webhook_params.merge(app: { _id: hotel.external_id }) }

        context 'guest exists' do
          let(:guest) { create(:guest) }
          let(:params) { base_params.merge(appUser: { _id: guest.external_id }) }

          it 'creates a message for the guest' do
            expect { post :create, params: params }.to change { guest.messages.count }.from(0).to(1)
          end
        end

        context 'guest does not exist' do
          let(:params) { base_params.merge(appUser: { _id: 'a-new-one' }) }
          let(:guest) { Guest.find_by(external_id: params[:appUser][:_id]) }
          let(:check_in) { guest.check_ins.last }
          before { post :create, params: params }

          it('creates the guest') { expect(guest).to be_present }
          it 'create a check in for new guest' do
            expect(check_in).to be_present
            expect(check_in.hotel_id).to eq(hotel.id)
          end
        end
      end

      context 'hotel does not exist' do
        it 'raises record not found' do
          expect { post :create, params: webhook_params }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
