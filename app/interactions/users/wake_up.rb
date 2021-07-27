# frozen_string_literal: true

require "active_interaction"

module Users
  class WakeUp < ActiveInteraction::Base
    object :user
    time :woke_up_at, default: Time.zone.now

    validate :validate_uesr

    def execute
      last_sleep = user.last_sleep
      last_sleep.end_at = woke_up_at

      unless last_sleep.save
        errors.merge!(last_sleep.errors)
      end

      last_sleep
    end

    private

    def validate_uesr
      errors.add(:user, :is_awake) unless user.sleeping?
    end
  end
end
