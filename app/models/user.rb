# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleeps, dependent: :destroy

  validates :name, presence: true

  def last_sleep
    sleeps.last
  end

  def sleeping?
    !!last_sleep && last_sleep.in_progress?
  end
end
