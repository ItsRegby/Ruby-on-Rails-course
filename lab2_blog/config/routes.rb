Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :two_factor_auth, only: [:show] do
    post :verify
  end

  devise_for :users, controllers: { sessions: 'sessions' }

  root 'posts#index'

  resource :profile, only: [:show, :edit, :update]

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :categories
end
