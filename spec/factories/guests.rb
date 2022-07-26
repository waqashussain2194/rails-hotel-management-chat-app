FactoryGirl.define do
  factory :guest do
    sequence(:external_id) { |i| "guest-dummy-#{i}" }
  end
end
