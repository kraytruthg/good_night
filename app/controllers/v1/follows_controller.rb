# frozen_string_literal: true

module V1
  class FollowsController < ApplicationController
    def create
      Follow.create!(
        follower: @current_user,
        following_id: params[:following_id]
      )
      head(:created)
    end

    def destroy
      follow = @current_user.following_relationships.find(params[:id])
      follow&.destroy

      head(:ok)
    end
  end
end
