class Sleep < ApplicationRecord
  belongs_to :user
  validates :start_at, presence: true
  validate :end_at_is_after_start_at

  def length
    end_at - start_at
  end

  private

  def end_at_is_after_start_at
    return unless start_at && end_at

    errors.add(:end_at, :end_at_must_be_after_start_at) unless end_at > start_at
  end
end
