# frozen_string_literal: true

module V1
  class SleepsController < ApplicationController
    def index
      @sleeps = if user = User.find_by(id: params[:user_id])
        Sleep.where(user: user).order(created_at: :desc)
      else
        Sleep.all.order(created_at: :desc)
      end
    end
  end
end
