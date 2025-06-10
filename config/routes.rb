Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "contact", to: "pages#contact"

  resources :meals do
    resources :exchanges, only: [:index, :new, :create]

    member do
      delete 'remove_photo/:photo_id', to: 'meals#remove_photo', as: :remove_photo
    end
  end

  resources :exchanges, only: :show do
    member do
      patch :accept
      patch :decline
      get :edit_rating
      patch :update_rating
    end

    resources :messages, only: [:index, :create]
  end

  get '/my-meals', to: 'meals#my_meals', as: :user_meals
  get '/my-shares', to: 'exchanges#my_exchanges', as: :user_exchanges
  get '/shares-dashboard', to: 'exchanges#exchanges_dashboard', as: :exchanges_dashboard
  get '/profile', to: 'users#show', as: :user_profile
  get '/share-requests', to: 'exchanges#exchange_requests', as: :exchange_requests
  get '/users/:id/view', to: 'users#view', as: :view_user
  get '/messages-dashboard', to: 'exchanges#exchanges_dashboard', as: :messages_dashboard
  get "up" => "rails/health#show", as: :rails_health_check
end
