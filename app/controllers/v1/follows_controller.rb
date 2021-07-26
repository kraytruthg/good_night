# frozen_string_literal: true

module V1
  class FollowsController < ApplicationController
    def create
      follow = Follow.new(
        follower_id: params[:user_id],
        followed_user_id: params[:followed_user_id]
      )

      if follow.save
        head(:created)
      else
        # escape the errors caused by followed already
        if follow.errors.all? { |e| e.type == :taken }
          head(:created)
        else
          render(
            json: { errors: follow.errors.full_messages },
            status: :unprocessable_entity
          )
        end
      end
    end

    def destroy
      follow = Follow.find_by(id: params[:id])
      follow&.destroy

      head(:ok)
    end
  end
end
