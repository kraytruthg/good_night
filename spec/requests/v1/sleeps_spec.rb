# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::SleepsController do
  context "GET /users/:user_id/sleeps" do
    let(:user) { FactoryBot.create(:user) }
    
    it "returns user's sleep records" do
      FactoryBot.create(:sleep, user: user) 
      FactoryBot.create(:sleep)

      get "/v1/users/#{user.id}/sleeps"

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(user.sleeps.count)
    end

    it "returns records ordered by created_at desc" do
      old_sleep = FactoryBot.create(:sleep, user: user)
      latest_sleep = FactoryBot.create(:sleep, user: user, start_at: Time.now + 1)

      get "/v1/users/#{user.id}/sleeps"

      json_response = JSON.parse(response.body)
      ids = json_response.map { |record| record["id"] }
      expect(ids).to eq([latest_sleep.id, old_sleep.id])
    end

    context "when the sleep is finished" do
      it "return sleep records in JSON" do
        sleep = FactoryBot.create(:sleep, user: user)

        get "/v1/users/#{user.id}/sleeps"

        json_response = JSON.parse(response.body)

        expect(json_response[0]).to match({
          "id"          => sleep.id,
          "length"      => sleep.length,
          "in_progress" => sleep.in_progress?,
          "start_at"    => sleep.start_at.utc.as_json,
          "end_at"      => sleep.end_at.utc.as_json,
          "created_at"  => sleep.created_at.utc.as_json,
          "updated_at"  => sleep.updated_at.utc.as_json
        })
      end
    end

    context "when the sleep is in progress" do
      it "return sleep records in JSON" do
        sleep = FactoryBot.create(:sleep, :in_progress, user: user)

        get "/v1/users/#{user.id}/sleeps"

        json_response = JSON.parse(response.body)

        expect(json_response[0]).to match({
          "id"          => sleep.id,
          "length"      => sleep.length,
          "in_progress" => sleep.in_progress?,
          "start_at"    => sleep.start_at.utc.as_json,
          "end_at"      => nil,
          "created_at"  => sleep.created_at.utc.as_json,
          "updated_at"  => sleep.updated_at.utc.as_json
        })
      end
    end
  end

  context "GET /users/:user_id/sleeps/by_friends" do
    let(:user) { FactoryBot.create(:user) }
    let!(:following) do
      FactoryBot.create(:user).tap do |following|
        FactoryBot.create(:follow, follower: user, following: following)
        FactoryBot.create(:sleep, user: following, start_at: 1.days.ago)
      end
    end
    let!(:follower) do
      FactoryBot.create(:user).tap do |follower|
        FactoryBot.create(:follow, follower: follower, following: user)
        FactoryBot.create(:sleep, user: follower)
      end
    end

    it "returns friends sleeps" do
      get "/v1/users/#{user.id}/sleeps/by_friends"

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(following.sleeps.count)
    end

    it "return sleep records in JSON" do
      get "/v1/users/#{user.id}/sleeps/by_friends"

      json_response = JSON.parse(response.body)

      row = json_response.first
      sleep = Sleep.find(row["id"])

      expect(json_response[0]).to match(
        "id"          => sleep.id,
        "length"      => sleep.length,
        "in_progress" => sleep.in_progress?,
        "start_at"    => sleep.start_at.utc.as_json,
        "end_at"      => sleep.end_at.utc.as_json,
        "created_at"  => sleep.created_at.utc.as_json,
        "updated_at"  => sleep.updated_at.utc.as_json,
        "user"        => {
                           "id" => sleep.user.id,
                           "name" => sleep.user.name
                         }
      )
      
    end

    describe "records order" do
      let!(:long_sleep) { FactoryBot.create(:sleep, user: following, start_at: 6.days.ago, end_at: 5.days.ago) }
      let!(:short_sleep) { FactoryBot.create(:sleep, user: following, start_at: Time.now - 1, end_at: Time.now) }

      it "by length DESC" do
        get "/v1/users/#{user.id}/sleeps/by_friends"

        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response.first["id"]).to eq(long_sleep.id)
        expect(json_response.last["id"]).to eq(short_sleep.id)
      end
    end
  end
end
