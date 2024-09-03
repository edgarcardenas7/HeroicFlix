Rails.application.routes.draw do
  resources :genres
  resources :users

  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end
  
  get "signin" => "sessions#new"
  resource :session, only: [:new, :create, :destroy]
  get "signup" => "users#new"
  
  # Route for filtering movies
  get "movies/filter/:filter", to: "movies#index", as: :filtered_movies
end
