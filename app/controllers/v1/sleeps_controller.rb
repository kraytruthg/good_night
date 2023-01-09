# frozen_string_literal: true

module V1
  class SleepsController < ApplicationController
    def index
      @sleeps = Sleep.where(user_id: params[:user_id]).order(created_at: :desc)
    end

    def by_friends
      user = User.find_by(id: params[:user_id])
      @sleeps = Sleep.where(user: @current_user.following_relationships.select(:following_id), start_at: 7.days.ago..Time.now).order(length: :desc)
    end
  end
end
