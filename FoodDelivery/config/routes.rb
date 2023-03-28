Rails.application.routes.draw do
  # get "home", to: 'home#index'
  
  # root to: 'home#index'
  get 'password', to: 'passwords#edit'
  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get 'sign_up', to: 'users#new'
  post 'sign_up', to: "users#create"

  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"
  
  put "account", to: "users#update"
  get "account", to: "users#edit"
  delete "account", to: "users#destroy"


  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token
  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token
  resources :active_sessions, only: [:destroy] do
    collection do
      delete "destroy_all"
    end
  end
  get "sales/new"

  root "welcome#index"
  resources :foods do
    resources :comments
  end
  
  resources :categories
  resources :cart_items
  resources :carts
  resources :administrator
  resources :about
  resources :sales
  resources :users do
    resources :orders
  end

  get "display/:option" => "sales#display", as: "display"
  get "login" => "sessions#new"
  get "/payment/processed" => "checkout#create", as: :get_payment_completed
  get "admin" => "administrator#show", as: :dashboard
  get "admin/foods" => "administrator#food_index", as: :admin_foods
  get "admin/orders" => "administrator#order_index", as: :admin_orders
  get "admin/users" => "administrator#user_index", as: :admin_users
  get "admin/sales" => "administrator#sale_index", as: :admin_sales
  get "admin/categories" => "administrator#category_index",
      as: :admin_categories
  post "login" => "sessions#create"
  post "checkout" => "checkout#show", as: :checkout
  post "carts/checkout" => "carts#checkout", as: :cart_checkout
  post "payment" => "checkout#create", as: :payment
  post "/foods/:food_id/comments(.:format)" => "comments#create",
       as: :create_food_comment
  post "/payment/processed" => "checkout#create", as: :payment_completed
  patch "order_status" => "administrator#update", as: :order_status
  patch "/foods/:food_id/edit_status" => "foods#edit_status", as: :edit_status
  delete "logout" => "sessions#destroy"
  delete "carts/:item_id/", to: "carts#destroy", as: :cart_item_delete

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
