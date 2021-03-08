require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => 'sidekiq'

  root to: 'currencies#index'
  get 'admin', to: 'mocks#new'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :currencies, only: [:index] do
  end
  resources :mocks, only: [:new, :create, :update] do
  end

end
