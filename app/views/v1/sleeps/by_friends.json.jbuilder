# frozen_string_literal: true

json.array! @sleeps, partial: "v1/sleeps/sleep", as: :sleep, locals: { show_user: true}
