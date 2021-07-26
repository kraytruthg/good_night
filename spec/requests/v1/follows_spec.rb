# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::FollowsController do
  let(:user) { FactoryBot.create(:user) }
  let(:followed_user) { FactoryBot.create(:user) }

  context "POST /users/:user_id/follows" do
    it "returns created" do
      post "/v1/users/#{user.id}/follows", params: { followed_user_id: followed_user.id }

      expect(response).to have_http_status(:created)
    end

    context "when user is not exist" do
      let(:not_existed_user_id) { 0 }

      it "returns 422" do
        post "/v1/users/#{not_existed_user_id}/follows", params: { followed_user_id: followed_user.id }

        expect(response).to have_http_status(422)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to be_present
      end
    end

    context "when followed user is not exist" do
      let(:not_existed_user_id) { 0 }

      it "returns 422" do
        post "/v1/users/#{user.id}/follows", params: { followed_user_id: not_existed_user_id }

        expect(response).to have_http_status(422)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to be_present
      end
    end

    context "when already followed" do
      before { FactoryBot.create(:follow, follower: user, followed_user: followed_user) }

      it "returns created without actually creating a record" do
        post "/v1/users/#{user.id}/follows", params: { followed_user_id: followed_user.id }

        expect(response).to have_http_status(:created)
      end
    end
  end

  context "DELETE /users/:user_id/follows/:id" do
    let(:follow) { FactoryBot.create(:follow, follower: user, followed_user: followed_user) }

    it "returns ok" do
      delete "/v1/users/#{user.id}/follows/#{follow.id}"

      expect(response).to have_http_status(:ok)
    end

    context "when follow not exist" do
      let(:not_existed_follow_id) { 0 }

      it "still returns ok" do
        delete "/v1/users/#{user.id}/follows/#{not_existed_follow_id}"

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
