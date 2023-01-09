# frozen_string_literal: true

module V1
  class FollowsController < ApplicationController
    def create
      follow = Follow.new(
        follower: @current_user,
        following_id: params[:following_id]
      )

      if follow.save
        head(:created)
      elsif follow.errors.all? { |e| e.type == :taken }
        # escape the errors caused by followed already
        head(:created)
      else
        render(
          json: { errors: follow.errors.full_messages },
          status: :unprocessable_entity
        )
      end
    end

    def destroy
      follow = Follow.find_by(id: params[:id])
      follow&.destroy

      head(:ok)
    end
  end
end
