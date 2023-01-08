# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1, defaults: { format: "json" } do
    resources :users, only: [] do
      post :sleep
      post :wake_up

      resources :sleeps, only: [:index]
      get "/sleeps/by_friends" => "sleeps#by_friends"

      resources :follows, only: %i[create destroy]
    end
  end
end
