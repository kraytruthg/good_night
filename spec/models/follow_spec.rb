# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Follow" do
  subject(:follow) { FactoryBot.create(:follow) }

  it { should validate_uniqueness_of(:follower_id).scoped_to(:followed_user_id) }
end
