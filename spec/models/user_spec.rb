# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User" do
  subject(:user) { FactoryBot.create(:user) }

  it { is_expected.to validate_presence_of(:name) }

  describe "#sleeping?" do
    context "when there is no sleep records" do
      it "returns false" do
        expect(user.sleeping?).to eq(false)
      end
    end

    context "when last sleep is finish" do
      it "returns false" do
        FactoryBot.create(:sleep, user: user)

        expect(user.sleeping?).to eq(false)
      end
    end

    context "when last sleep is in progress" do
      it "returns true" do
        FactoryBot.create(:sleep, :in_progress, user: user)

        expect(user.sleeping?).to eq(true)
      end
    end
  end
end
