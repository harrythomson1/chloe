Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root "dashboard#index"
    get "/dashboard", to: "dashboard#index"
  end

  unauthenticated do
    root "devise/sessions#new", as: :unauthenticated_root
  end

  resources :conditions, only: [:index] do
  end

  resources :medications, only: [:index] do
  end

  resources :user_conditions, only: [:create, :destroy]
  get "up" => "rails/health#show", as: :rails_health_check
end
