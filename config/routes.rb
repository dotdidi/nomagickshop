Rails.application.routes.draw do
  

  get '/welcome', to: 'sessions#new'

  post '/welcome', to: 'sessions#create'

  delete '/bye', to: 'sessions#destroy'

  resources :users

  resources :products

end
