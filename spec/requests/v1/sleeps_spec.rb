# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::SleepsController do
  context "GET /users/:user_id/sleeps" do
    let(:user) { FactoryBot.create(:user) }

    it "returns user's sleep records" do
      2.times { |_i| FactoryBot.create(:sleep, user: user) }
      2.times { |_i| FactoryBot.create(:sleep) }

      get "/v1/users/#{user.id}/sleeps", params: { format: :json }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(user.sleeps.count)
    end

    it "returns records in order" do
      old_sleep = FactoryBot.create(:sleep, user: user)
      latest_sleep = FactoryBot.create(:sleep, user: user)

      get "/v1/users/#{user.id}/sleeps", params: { format: :json }

      json_response = JSON.parse(response.body)
      ids = json_response.map { |record| record["id"] }
      expect(ids).to eq([latest_sleep.id, old_sleep.id])
    end

    context "when the sleep is finished" do
      it "return sleep records in JSON" do
        sleep = FactoryBot.create(:sleep, user: user)

        get "/v1/users/#{user.id}/sleeps", params: { format: :json }

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
        sleep = FactoryBot.create(:sleep, :in_progress, user: user)

        get "/v1/users/#{user.id}/sleeps", params: { format: :json }

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

  context "GET /users/:user_id/sleeps/by_friends" do
    let(:user) { FactoryBot.create(:user) }
    let!(:friend1) do
      FactoryBot.create(:user).tap do |friend|
        FactoryBot.create(:follow, follower: user, followed_user: friend)
        3.times { FactoryBot.create(:sleep, user: friend) }
      end
    end
    let!(:friend2) do
      FactoryBot.create(:user).tap do |friend|
        FactoryBot.create(:follow, follower: user, followed_user: friend)
        FactoryBot.create(:sleep, user: friend)
      end
    end

    it "returns friends sleeps" do
      get "/v1/users/#{user.id}/sleeps/by_friends", params: { format: :json }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(friend1.sleeps.count + friend2.sleeps.count)
    end

    describe "records order" do
      let!(:long_sleep) { FactoryBot.create(:sleep, user: friend1, start_at: 1.day.ago, end_at: Time.zone.now) }
      let!(:short_sleep) { FactoryBot.create(:sleep, user: friend2, start_at: 1.second.ago, end_at: Time.zone.now) }

      it "by length ASC" do
        get "/v1/users/#{user.id}/sleeps/by_friends", params: { format: :json }

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response.first["id"]).to eq(short_sleep.id)
        expect(json_response.last["id"]).to eq(long_sleep.id)
      end
    end
  end
end
