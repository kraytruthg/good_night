# frozen_string_literal: true

class Sleep < ApplicationRecord
  belongs_to :user
  validates :start_at, presence: true
  validates :end_at, comparison: { greater_than: :start_at, message: "must be after the start at" }, if: :end_at
  
  after_save :calculate_length

  def in_progress?
    !end_at
  end

  private

  def calculate_length
    return unless end_at
    
    # virtual column was calculated after commit, has to either reload or self assign
    self.length = end_at - start_at
  end
end
