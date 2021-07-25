require "rails_helper"

RSpec.describe 'Sleep' do
  subject(:sleep) { FactoryBot.create(:sleep) }

  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:start_at) }

  context "when end_at is earlier than start_at" do
    it "return error :end_at_must_be_after_start_at" do
      sleep.end_at = sleep.start_at - 1

      expect(sleep).to be_invalid
      expect(sleep.errors.full_messages).to include("End at must be after the start at")
    end
  end
end
