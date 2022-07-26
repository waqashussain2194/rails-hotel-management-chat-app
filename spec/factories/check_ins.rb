FactoryGirl.define do
  factory :check_in do
    trait :checked_out do
      checked_out_at { Time.current }
    end
  end
end
