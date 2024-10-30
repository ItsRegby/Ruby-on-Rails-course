Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  root 'posts#index'

  resource :profile, only: [:show, :edit, :update]

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :categories
end
