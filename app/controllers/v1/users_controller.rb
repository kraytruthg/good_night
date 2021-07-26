# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def sleep
      user = User.find(params[:user_id])

      outcome = Users::Sleep.run(user: user)

      if outcome.valid?
        head(:ok)
      else
        render(
          json: { errors: outcome.errors.full_messages },
          status: :unprocessable_entity
        )
      end
    end

    def wake_up
      user = User.find(params[:user_id])

      outcome = Users::WakeUp.run(user: user)

      if outcome.valid?
        head(:ok)
      else
        render(
          json: { errors: outcome.errors.full_messages },
          status: :unprocessable_entity
        )
      end
    end
  end
end
