require "rails_helper"

RSpec.describe V1::SleepsController do
  context "GET /sleeps" do
    it "returns success with all sleep records" do
      2.times { FactoryBot.create(:sleep) }

      get "/v1/sleeps", params: { format: :json }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(Sleep.count)
    end

    it "returns records in order" do
      old_sleep = FactoryBot.create(:sleep)
      latest_sleep = FactoryBot.create(:sleep)

      get "/v1/sleeps", params: { format: :json }

      json_response = JSON.parse(response.body)
      ids = json_response.map { |record| record["id"] }
      expect(ids).to eq([latest_sleep.id, old_sleep.id])
    end

    context "when user_id is passed in" do
      let(:user) { FactoryBot.create(:user) }

      it "returns user's sleep records" do
        3.times { |i| FactoryBot.create(:sleep, user: user) }
        2.times { |i| FactoryBot.create(:sleep) }

        get "/v1/sleeps", params: { user_id: user.id, format: :json }

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(user.sleeps.count)
      end
    end

    context "when the sleep is finished" do
      it "return sleep records in JSON" do
        sleep = FactoryBot.create(:sleep)

        get "/v1/sleeps", params: { format: :json }

        json_response = JSON.parse(response.body)

        row = json_response.first

        expect(row["id"]).to eq(sleep.id)
        expect(row["length"]).to eq(sleep.length)
        expect(row["in_progress"]).to eq(sleep.in_progress?)
        expect(row["start_at"]).to eq(sleep.start_at.utc.as_json)
        expect(row["end_at"]).to eq(sleep.end_at.utc.as_json)
      end
    end

    context "when the sleep is in progress" do
      it "return sleep records in JSON" do
        sleep = FactoryBot.create(:sleep, :in_progress)

        get "/v1/sleeps", params: { format: :json }

        json_response = JSON.parse(response.body)

        row = json_response.first

        expect(row["id"]).to eq(sleep.id)
        expect(row["length"]).to eq(nil)
        expect(row["in_progress"]).to eq(sleep.in_progress?)
        expect(row["start_at"]).to eq(sleep.start_at.utc.as_json)
        expect(row["end_at"]).to eq(nil)
      end
    end
  end
end
