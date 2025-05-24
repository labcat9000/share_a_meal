Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "contact", to: "pages#contact"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :meals do
    resources :exchanges, only: [:new, :create, :index]
  end

  resources :exchanges, only: [] do
    member do
      patch :accept
      patch :decline
    end
  end

  get '/your-meals', to: 'meals#your_meals', as: :user_meals
  get '/my-exchanges', to: 'exchanges#my_exchanges', as: :user_exchanges
  get '/profile', to: 'profiles#show', as: :user_profile

  get "up" => "rails/health#show", as: :rails_health_check
end
