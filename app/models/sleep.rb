class Sleep < ApplicationRecord
  belongs_to :user
  validates :start_at, presence: true
  validate :end_at_is_after_start_at

  def in_progress?
    !end_at
  end

  def length
    end_at - start_at
  end

  def to_builder
    Jbuilder.new do |sleep|
      sleep.user user.to_builder
      sleep.start_at start_at
      sleep.end_at end_at
      sleep.created_at created_at
      sleep.updated_at start_at
    end
  end

  private

  def end_at_is_after_start_at
    return unless start_at && end_at

    errors.add(:end_at, :end_at_must_be_after_start_at) unless end_at > start_at
  end
end
