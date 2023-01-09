# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def sleep
      outcome = Users::Sleep.run(user: @current_user)

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
      outcome = Users::WakeUp.run(user: @current_user)

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
