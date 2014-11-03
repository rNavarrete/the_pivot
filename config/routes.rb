Rails.application.routes.draw do

  root 'home#index'

  resources :items
	resources :orders
  resources :categories
  resources :addresses
  resources :users
  resources :home

  namespace :admin do
    resources :items, :categories, :orders, :order_items
    get 'dashboard', to: 'dashboard#show'
  end

  get ':id', to: 'stores#show', as: 'stores'

  get 'confirmation', to: 'confirmations#show'

  get 'code', to: 'home#code'

  get 'complete_delivery_order', to: 'orders#create'

  get 'checkout',         to: 'checkouts#show'
  get 'complete_order',   to: 'checkouts#complete_order'

  get 'cart',             to: 'carts#show',           as: 'cart'
  get 'add_item',         to: 'carts#add_item',       as: 'add_item'
  get 'remove_item',      to: 'carts#remove_item',    as: 'remove_item'
  put 'update_quantity',  to: 'carts#update_quantity',as: 'update_quantity'

  get 'stores', to: 'store_dashboard#index', as: 'store_dashboard'
  get 'stores/:store_name', to: 'store_dashboard#show', as: 'store_dashboard_show'

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'gift_cards',        to: 'gift_cards#show'
  get 'about',             to: 'about#show'
  resources "contact_us", only: [:new, :create]

end
