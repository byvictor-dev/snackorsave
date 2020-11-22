Rails.application.routes.draw do
  get 'api_credentials/show'
  get 'api_credentials/update'
  devise_for :users

  resources :api_credentials, only: [:index, :update]

  resources :blacklists, only: [:index, :new, :create, :edit, :update]

  get '/blacklisted', to: 'blacklisted#is_blacklisted', as: 'is_blacklisted'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
