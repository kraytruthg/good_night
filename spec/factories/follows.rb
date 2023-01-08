# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    association :follower, factory: :user
    association :following, factory: :user
  end
end
