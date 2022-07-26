require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should belong_to(:hotel) }
    it { should have_many(:messages) }
  end

  it 'has a valid factory' do
    hotel = FactoryGirl.build(:hotel)
    expect(FactoryGirl.build(:user, hotel: hotel)).to be_valid
  end
end
