# frozen_string_literal: true

module V1
  class SleepsController < ApplicationController
    def index
      user = User.find_by(id: params[:user_id])
      @sleeps = Sleep.where(user: user).order(created_at: :desc)
    end

    def by_friends
      user = User.find_by(id: params[:user_id])
      @sleeps = Sleep.where(user: user.followings).sort_by(&:length)
    end
  end
end
