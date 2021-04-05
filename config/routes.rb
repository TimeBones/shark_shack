Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cart, only: %i[create destroy index]
  resources :products, only: %i[show index]
  resources :categories, only: %i[show index]

  get "/about", to: "pages#about", as: "about_page"
  get "/search", to: "pages#search", as: "search_page"
  get "/logout", to: "users#logout", as: "user_logout"
  get "/account", to: "users#show", as: "account"
  get "/login", to: "users#login", as: "user_login"
  get "/newaccount", to: "users#newaccount", as: "new_account"
  post "/create", to: "users#create", as: "user_create"
  post "/logging", to: "users#logging", as: "user_logging"

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  scope "/cart" do
    post "create", to: "cart#create", as: "cart_create"
    get "destroy", to: "cart#destroy", as: "cart_destroy"
    get "empty", to: "cart#empty", as: "cart_empty"
    get "view", to: "cart#view", as: "cart_view"
  end

  root to: "pages#home"
end
