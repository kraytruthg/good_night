# frozen_string_literal: true

require "active_interaction"

module Users
  class Sleep < ActiveInteraction::Base
    object :user
    time :slept_at, default: Time.now

    validate :validate_uesr

    def execute
      sleep = user.sleeps.new(start_at: slept_at)

      unless sleep.save
        errors.merge(sleep.errors)
      end

      sleep
    end

    private

    def validate_uesr
      errors.add(:user, :is_sleeping) if user.sleeping?
    end
  end
end
