Rails.application.routes.draw do
  get 'products/index'

  get 'products/new'

  get 'products/edit'

  get 'products/show'

  root to: 'products#index'
  resources :products do

  end
end
