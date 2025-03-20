Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users
  root to: "flats#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :flats, only: [:index, :show] do
    resources :reservations, only: [:create, :show] do
      member do
        get :confirm
        get :confirmed
      end
    end
    resources :bookings, only: [:create, :show]

    # Added correct routes for messages
    resources :messages, only: [:index, :new, :show, :create], param: :id do
      # This will ensure you're passing the correct params in URLs
    end

    # Route to view messages for a specific flat for the landlord (updated to avoid conflict)
    get 'messages_for_landlord', to: 'flats#messages', as: 'messages_for_landlord'
  end

  resources :questions, only: [:index, :create]

  resources :users, only: [:show, :edit, :update]  # Ensure 'update' is included here
  get 'profile', to: 'users#profile', as: 'profile'
  get 'edit_profile', to: 'users#edit', as: 'edit_user_profile'  # This is the added route for the edit page
  patch 'profile', to: 'users#update', as: 'update_user_profile'
  patch 'users/update_role', to: 'users#update_role', as: 'update_role'
end
