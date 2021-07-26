FactoryBot.define do
  factory :sleep do
    user
    start_at { 10.hours.ago }
    end_at { 2.hours.ago}

    trait :in_progress do
      end_at { nil }
    end
  end
end
