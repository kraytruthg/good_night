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

  describe "#length" do
    it "return the sleep length in seconds" do
      time = Time.now
      sleep = FactoryBot.create(:sleep, start_at: time.advance(minutes: -1), end_at: time)

      expect(sleep.length).to eq(60)
    end

    context "when sleep in progress" do
      it "return nil" do
        sleep = FactoryBot.create(:sleep, :in_progress)

        expect(sleep.length).to be_nil
      end
    end
  end

  describe "#in_progress" do
    it "returns true when end_at is nil" do
      sleep = FactoryBot.create(:sleep, :in_progress)

      expect(sleep.in_progress?).to eq(true)
    end

    it "returns false when end_at is presence" do
      sleep = FactoryBot.create(:sleep)

      expect(sleep.in_progress?).to eq(false)
    end
  end
end
