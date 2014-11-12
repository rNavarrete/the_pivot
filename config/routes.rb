Rails.application.routes.draw do
  require 'resque/server'

  DinnerDash::Application.routes.draw do
   mount Resque::Server.new, at: "/resque"
  end

  match "/404" => "errors#error404", via: [:get, :post, :patch, :delete]

  resources :charges
  resources :items
  root 'home#index'
  resources :items
	resources :orders
  resources :categories
  resources :addresses

  resources :mailing_addresses, controller: 'addresses', type: 'MailingAddress'
  resources :billing_addresses, controller: 'addresses', type: 'BillingAddress'

  resources :users
  resources :home

  namespace :admin do
    resources :items, :categories, :orders, :order_items
    resources :stores, except: :patch
    patch 'stores/:id', to: 'stores#authorize_store', as: "authorize_store"
    get 'dashboard', to: 'dashboard#show'
  end

  get 'cart',        to: 'carts#show',  as: 'cart'

  get 'confirmation', to: 'confirmations#show'

  get 'code', to: 'home#code'

  get 'complete_delivery_order', to: 'orders#create'

  get 'checkout',         to: 'checkouts#show'
  get 'complete_order',   to: 'checkouts#complete_order'

  post 'add_item',         to: 'carts#add_item',       as: 'add_item'
  get 'remove_item',      to: 'carts#remove_item',    as: 'remove_item'
  put 'update_quantity',  to: 'carts#update_quantity',as: 'update_quantity'

  namespace :seller do
    resources :items, :orders
    get  'stores',                    to: 'seller#index',           as: 'dashboard'
    get  'store/:id/edit',            to: 'seller#edit',            as: 'store_edit'
    get  'store/:id',                 to: 'seller#show',            as: 'store_show'
    patch 'store/:id',                to: 'seller#update',          as: 'store_update'
    patch 'store/add_manager/:id',    to: 'seller#add_manager',     as: 'store_add_manager'
    patch 'store/remove_manager/:id', to: 'seller#remove_manager',  as: 'store_remove_manager'
  end

  get 'stores', to: 'store_dashboard#index', as: 'store_dashboard'

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get  'request_store', to: 'stores#new', as: 'request_store'
  post 'send_store_request',  to: 'stores#create'

  get 'about',      to: 'about#show'

  get "contact_us", to: 'contact_us#new'
  resources "contact_us", only: [:create]

  get ':store_name', to: 'stores#show', as: 'stores'
end
