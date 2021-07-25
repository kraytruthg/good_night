FactoryBot.define do
  factory :sleep do
    user
    start_at { 10.hours.ago }
    end_at { 2.hours.ago}
  end
end
