# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::WakeUp do
  let(:user) { FactoryBot.create(:user) }
  let(:woke_up_at) { Time.zone.now }
  let!(:last_sleep) { FactoryBot.create(:sleep, :in_progress, user: user) }
  subject(:outcome) { described_class.run(user: user, woke_up_at: woke_up_at) }

  describe ".run" do
    it "update the last sleep record" do
      expect {
        outcome
      }.to change {
        user.last_sleep.reload.end_at
      }.from(nil).to(woke_up_at)

      expect(outcome).to be_valid
      expect(user).not_to be_sleeping
    end

    context "when user is not in sleep" do
      let!(:last_sleep) { FactoryBot.create(:sleep, user: user) }

      it "returns error" do
        expect(outcome).to be_invalid
        expect(outcome.errors.full_messages).to include("User is already awake")
      end
    end
  end
end
