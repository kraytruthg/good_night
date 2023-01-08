# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Follow" do
  subject(:follow) { FactoryBot.create(:follow) }

  it { should belong_to(:follower) } 
  it { should belong_to(:following) } 
  it { should validate_uniqueness_of(:follower_id).scoped_to(:following_id) }
end
