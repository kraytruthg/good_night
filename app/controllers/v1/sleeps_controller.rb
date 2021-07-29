# frozen_string_literal: true

module V1
  class SleepsController < ApplicationController
    def index
      @sleeps = Sleep.where(user_id: params[:user_id]).order(created_at: :desc)
    end

    def by_friends
      user = User.find_by(id: params[:user_id])
      @sleeps = Sleep.where(user: user.followings).sort_by(&:length)
    end
  end
end
