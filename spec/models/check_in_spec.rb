require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  describe 'Associations' do
    it { should belong_to(:guest) }
    it { should belong_to(:hotel) }
  end

  it 'has a valid factory' do
    hotel = FactoryGirl.create(:hotel)
    guest = FactoryGirl.create(:guest)
    expect(FactoryGirl.create(:check_in, hotel: hotel, guest: guest)).to be_valid
  end
end
