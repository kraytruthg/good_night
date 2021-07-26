# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User" do
  subject(:user) { FactoryBot.create(:user) }

  it { is_expected.to validate_presence_of(:name) }
end
