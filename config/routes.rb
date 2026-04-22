Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :posts, only: [ :index, :show ]

  namespace :admin do
    root "dashboard#index"
    resource :user, only: %i[show edit update destroy]
    resources :posts do
      member do
        patch :publish
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
