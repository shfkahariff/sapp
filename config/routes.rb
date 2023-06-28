Rails.application.routes.draw do
  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  resources :tickets
  resources :events
  resources :shops, only: [:index, :show]
  get 'home/index'
  root 'shops#index'
  get 'cart/carthome'
  post 'cart/add_all', to: 'cart#add_all', as: 'cart_add_all'
  post '/checkout', to: 'details#checkout', as: 'checkout'
  patch '/cart', to: 'cart#update', as: 'update_cart'
  get '/cart/:id/detail', to: 'cart#detail', as: 'cart_detail'

  resources :cart do
    member do
      get 'print', to: 'cart#print', format: :pdf
    end
  end
end
