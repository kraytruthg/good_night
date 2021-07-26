Rails.application.routes.draw do
  namespace :v1, constraints: { format: 'json' } do
    resources :sleeps, only: [:index]
    resources :users, only: [:index, :show] do
      post :sleep
      post :wake_up
    end
  end
end
