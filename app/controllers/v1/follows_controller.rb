# frozen_string_literal: true

module V1
  class FollowsController < ApplicationController
    def create
      Follow.create!(
        follower: @current_user,
        following_id: params[:following_id]
      )
      head(:created)
    rescue ActiveRecord::RecordInvalid => e
      if e.record.errors.all? { _1.type == :taken }
        head(:created)
      else
        super
      end
    end

    def destroy
      follow = Follow.find_by(id: params[:id])
      follow&.destroy

      head(:ok)
    end
  end
end
