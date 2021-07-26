json.extract! sleep, :id, :start_at, :end_at, :created_at, :updated_at
json.length sleep.length
json.in_progress sleep.in_progress?

