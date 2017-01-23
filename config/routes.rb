Rails.application.routes.draw do

  root 'products#index'

  get '/welcome', to: 'sessions#new'

  post '/welcome', to: 'sessions#create'

  delete '/bye', to: 'sessions#destroy'

  resources :orders

  resources :users

  resources :products

  resources :line_items

  resources :carts

  resources :transactions

end
