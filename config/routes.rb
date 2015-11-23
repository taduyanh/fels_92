Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  # You can have the root of your site routed with "root"
  root 'users#index'

  resources :users
  resources :followers, only: [:index, :create, :destroy]
end
