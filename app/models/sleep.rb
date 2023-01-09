# frozen_string_literal: true

class Sleep < ApplicationRecord
  belongs_to :user
  validates :start_at, presence: true
  validate :end_at_is_after_start_at
  
  after_save :calculate_length

  def in_progress?
    !end_at
  end

  private

  def end_at_is_after_start_at
    return unless start_at && end_at

    errors.add(:end_at, :end_at_must_be_after_start_at) unless end_at > start_at
  end

  def calculate_length
    return unless end_at
    
    # virtual column was calculated after commit, has to either reload or self assign
    self.length = end_at - start_at
  end
end
