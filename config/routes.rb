Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :flats, only: [:index, :show] do
    resources :reservations, only: [:create, :show] # Add nested routes for reservations
    resources :bookings, only: [:create, :show] # Add nested routes for bookings
  end

  resources :questions, only: [:index, :create]
end
