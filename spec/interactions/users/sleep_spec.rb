# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::Sleep do
  let(:user) { FactoryBot.create(:user) }
  subject(:outcome) { described_class.run(user: user) }

  describe ".run" do
    it "creates sleep record" do
      expect {
        outcome
      }.to change {
        user.sleeps.count
      }.by(1)

      expect(outcome).to be_valid
      expect(outcome.result).to be_a(Sleep)

      expect(user).to be_sleeping
    end

    context "when user is in sleep" do
      before { described_class.run(user: user) }

      it "returns error" do
        expect {
          outcome
        }.not_to change {
          user.sleeps.count
        }

        expect(outcome).to be_invalid
        expect(outcome.errors.full_messages).to include("User is already asleep")
      end
    end
  end
end
