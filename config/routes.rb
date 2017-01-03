Rails.application.routes.draw do
  
  get 'carts/show'

  root 'products#index'

  get '/welcome', to: 'sessions#new'

  post '/welcome', to: 'sessions#create'

  delete '/bye', to: 'sessions#destroy'

  resources :users

  resources :products

  resources :line_items

end
