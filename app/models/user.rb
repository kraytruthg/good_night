# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleeps, dependent: :destroy

  validates :name, presence: true

  def sleeping?
    !!sleeps.last && sleeps.last.in_progress?
  end
end
