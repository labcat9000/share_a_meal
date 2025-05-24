Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "contact", to: "pages#contact"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :meals do
    resources :exchanges, only: [:index, :new, :create]
  end

  resources :exchanges, only: [] do
    member do
      patch :accept
      patch :decline
    end
  end

  get '/my-meals', to: 'meals#my_meals', as: :user_meals
  get '/my-shares', to: 'exchanges#my_exchanges', as: :user_exchanges
  get '/shares-dashboard', to: 'exchanges#exchanges_dashboard', as: :exchanges_dashboard
  get '/profile', to: 'users#show', as: :user_profile
  get '/share-requests', to: 'exchanges#exchange_requests', as: :exchange_requests

  get "up" => "rails/health#show", as: :rails_health_check
end
