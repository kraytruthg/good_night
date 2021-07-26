require "rails_helper"

RSpec.describe V1::SleepsController do
  describe "GET index" do
    let!(:sleeps) { 5.times { |i| FactoryBot.create(:sleep) } }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected sleeps attributes" do
      get :index
      debugger
      json_response = JSON.parse(response.body)
      expect(hash_body.keys).to match_array([:id, :ingredients, :instructions])
    end
  end
end
