require "rails_helper"

RSpec.describe V1::SleepsController do
  context "GET /sleeps" do
    let(:user) { FactoryBot.create(:user) }
    before do
      3.times { |i| FactoryBot.create(:sleep, user: user) }
      2.times { |i| FactoryBot.create(:sleep) }
    end

    it "returns all sleep records" do
      get "/v1/sleeps", params: { format: :json }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(Sleep.count)
    end

    it "return sleep records in JSON" do
      get "/v1/sleeps", params: { format: :json }

      json_response = JSON.parse(response.body)

      first_row = json_response.first
      last_sleep = Sleep.last

      expect(first_row["id"]).to eq(last_sleep.id)
      expect(first_row["length"]).to eq(last_sleep.length)
      expect(first_row["in_progress"]).to eq(last_sleep.in_progress?)
      expect(first_row["start_at"]).to eq(last_sleep.start_at.utc.as_json)
      expect(first_row["end_at"]).to eq(last_sleep.end_at.utc.as_json)
    end

    context "when user_id is passed in" do
      it "returns user's sleep records" do
        get "/v1/sleeps", params: { user_id: user.id, format: :json }

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(user.sleeps.count)
      end
    end
  end
end
