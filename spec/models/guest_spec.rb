require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'Associations' do
    it { should have_many(:check_ins) }
    it { should have_many(:messages) }
  end

  describe 'Validations' do
    let!(:guest) { create(:guest) }

    it { should validate_presence_of(:external_id) }
    it { should validate_uniqueness_of(:external_id).case_insensitive }
  end

  it 'has a valid factory' do
    expect(FactoryGirl.build(:guest)).to be_valid
  end
end
