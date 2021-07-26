# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::Sleep do
  let(:user) { FactoryBot.create(:user) }
  subject(:outcome) { described_class.run(user: user) }

  describe ".run" do
    it "creates sleep record" do
      expect(outcome).to be_valid
      expect(outcome.result).to be_a(Sleep)

      expect(user).to be_sleeping

      sleep = outcome.result
      expect(sleep.user).to eq(user)
    end

    context "when user is in sleep" do
      before { described_class.run(user: user) }

      it "returns error" do
        expect(outcome).to be_invalid
        expect(outcome.errors.full_messages).to include("User is already asleep")
      end
    end
  end
end
