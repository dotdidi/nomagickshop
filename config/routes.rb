Rails.application.routes.draw do

  root to: 'users#index'
  
  resources :users
 
  resources :products, only: [:index, :show]

  resources :products, only: [:new, :create, :update, :destroy], module: 'admin'
  
end
