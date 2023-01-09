# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
follower = User.find_by(name: "follower")
(1..200).each do |i|
  user = User.create(name: "user#{i}")
  Follow.create(follower: follower, following_id: user.id)

  (1..10).each do |days|
    user.sleeps.create(
      start_at: Time.zone.now.advance(days: -1 * days, hours: -1 * rand(1..12)),
      end_at: Time.zone.now.advance(days: -1 * days)
    )
  end
end
