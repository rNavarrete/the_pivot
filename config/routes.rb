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

  get 'cart',        to: 'carts#show',  as: 'cart'

  get 'confirmation', to: 'confirmations#show'

  get 'code', to: 'home#code'

  get 'complete_delivery_order', to: 'orders#create'

  get 'checkout',         to: 'checkouts#show'
  get 'complete_order',   to: 'checkouts#complete_order'

  get 'add_item',         to: 'carts#add_item',       as: 'add_item'
  get 'remove_item',      to: 'carts#remove_item',    as: 'remove_item'
  put 'update_quantity',  to: 'carts#update_quantity',as: 'update_quantity'

  namespace :seller do
    resources :items, :orders
    get  'stores',        to: 'seller#index',   as: 'dashboard'
    get  'store/:id/edit', to: 'seller#edit',   as: 'store_edit'
    get  'store/:id',     to: 'seller#show',    as: 'store_show'
    patch 'store/:id',    to: 'seller#update',  as: 'store_update'
  end


  get 'stores', to: 'store_dashboard#index', as: 'store_dashboard'

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  get 'gift_cards', to: 'gift_cards#show'
  get 'about',      to: 'about#show'

  resources "contact_us", only: [:new, :create]
  get ':store_name', to: 'stores#show', as: 'stores'
end
