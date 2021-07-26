# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..10).each do |i|
  user = User.create(name: "user#{i}")
  (1..i).each do |days|
    user.sleeps.create(
      start_at: Time.zone.now.advance(days: -days, hours: -8),
      end_at: Time.zone.now.advance(days: -days)
    )
  end
end
