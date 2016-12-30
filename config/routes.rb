Rails.application.routes.draw do
  
  root 'users#index'

  get '/welcome', to: 'sessions#new'

  post '/welcome', to: 'sessions#create'

  delete '/bye', to: 'sessions#destroy'

  resources :users

  resources :products

end
