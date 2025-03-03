Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :flats, only: [:index, :show] do
    resources :reservations, only: [:create, :show] do
      member do
        get :confirm
        get :confirmed
      end
    end
    resources :bookings, only: [:create, :show]
  end

  resources :questions, only: [:index, :create]
end
