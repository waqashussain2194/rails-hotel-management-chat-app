require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'Associations' do
    it { should belong_to(:guest) }
    it { should belong_to(:hotel) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:content) }
  end

  it 'has a valid factory' do
    hotel = FactoryGirl.create(:hotel)
    guest = FactoryGirl.create(:guest)
    expect(FactoryGirl.build(:message, hotel: hotel, guest: guest)).to be_valid
  end
end
