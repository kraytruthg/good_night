# frozen_string_literal: true

if local_assigns[:show_user]
  json.user do
    json.id sleep.user.id
    json.name sleep.user.name
  end
end
json.extract! sleep, :id, :start_at, :end_at, :created_at, :updated_at
json.length sleep.length
json.in_progress sleep.in_progress?
