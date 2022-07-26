require 'sidekiq/web'
Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :guests, only: :index
      resources :messages, only: %i[index create]
      resources :notifications, only: %i[index destroy]
    end
  end

  namespace :users, path: '/staff' do
    get 'console', to: 'guests#index'
    resources :guests, only: :show
  end

  namespace :webhooks do
    namespace :smooch do
      resources :messages, only: :create
    end
  end

  root to: 'pages#landing'
end
