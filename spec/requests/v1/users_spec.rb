# frozen_string_literal: true

require "rails_helper"

RSpec.describe V1::UsersController do
  let(:user) { FactoryBot.create(:user) }

  context "POST /users/:user_id/sleep" do
    it "returns success" do
      post "/v1/users/#{user.id}/sleep"

      expect(response).to have_http_status(:success)
    end

    context "when user is asleep" do
      before { FactoryBot.create(:sleep, :in_progress, user: user) }

      it "returns 422" do
        post "/v1/users/#{user.id}/sleep"

        expect(response).to have_http_status(422)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to be_present
      end
    end
  end

  context "POST /users/:user_id/wake_up" do
    context "when user is asleep" do
      before { FactoryBot.create(:sleep, :in_progress, user: user) }

      it "returns success" do
        post "/v1/users/#{user.id}/wake_up"

        expect(response).to have_http_status(:success)
      end
    end

    context "when user is awake" do
      it "returns 422" do
        post "/v1/users/#{user.id}/wake_up"

        expect(response).to have_http_status(422)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to be_present
      end
    end
  end
end
