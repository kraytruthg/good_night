# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def sleep
      Users::Sleep.run!(user: @current_user)

      set_sleeps
    end

    def wake_up
      Users::WakeUp.run!(user: @current_user)

      set_sleeps
    end

    private 

    def set_sleeps
      @sleeps = @current_user.sleeps.order(created_at: :desc)
    end
  end
end
