# frozen_string_literal: true

module V1
  class SleepsController < ApplicationController
    def index
      @sleeps = Sleep.where(user: @current_user).order(created_at: :desc)
    end

    def by_friends
      @sleeps = Sleep.where(
        user: @current_user.following_relationships.select(:following_id), 
        start_at: 7.days.ago..Time.now
      ).order(length: :desc).includes(:user)
    end
  end
end
