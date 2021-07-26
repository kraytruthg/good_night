# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleeps, dependent: :destroy

  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user

  validates :name, presence: true

  def last_sleep
    sleeps.last
  end

  def sleeping?
    !!last_sleep && last_sleep.in_progress?
  end
end
