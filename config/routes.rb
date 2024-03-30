Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :teams
    resources :players
    resources :player_rounds
    resources :matches
    resources :backfill do
      collection do
        post 'create'
      end
    end
  end
end
