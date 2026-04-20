Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root "dashboard#index"
    get "/dashboard", to: "dashboard#index"
  end

  unauthenticated do
    root "devise/sessions#new", as: :unauthenticated_root
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
