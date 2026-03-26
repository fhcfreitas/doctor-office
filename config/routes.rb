Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  namespace :admin do
    root "dashboard#index"
    resource :user, only: %i[show edit update destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
