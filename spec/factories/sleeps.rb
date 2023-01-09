# frozen_string_literal: true

FactoryBot.define do
  factory :sleep do
    user
    start_at { Time.now }
    end_at { start_at.advance(hours: 8) }

    trait :in_progress do
      end_at { nil }
    end
  end
end
