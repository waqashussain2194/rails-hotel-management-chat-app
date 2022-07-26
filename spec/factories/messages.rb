FactoryGirl.define do
  factory :message do
    sequence(:content) { |i| "Test message #{i}" }
  end
end
