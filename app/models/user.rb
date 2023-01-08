# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleeps, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :following_relationships, source: :following

  validates :name, presence: true

  def sleeping?
    !!sleeps.last&.in_progress?
  end
end
