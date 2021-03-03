Rails.application.routes.draw do
  root to: 'currencies#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :currencies, only: [:index] do
  end
end
