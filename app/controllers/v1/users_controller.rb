# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def sleep
      Users::Sleep.run!(user: @current_user)
    end

    def wake_up
      Users::WakeUp.run!(user: @current_user)
    end
  end
end
