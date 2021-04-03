Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cart, only: %i[create destroy index]
  resources :products, only: %i[show index]
  resources :categories, only: %i[show index]

  get "/about", to: "pages#about", as: "about_page"
  get "/logout", to: "users#logout", as: "user_logout"
  get "/account", to: "users#show", as: "account"
  get "/login", to: "users#login", as: "user_login"
  get "/newaccount", to: "users#newaccount", as: "new_account"
  post "create", to: "users#create", as: "user_create"
  post "logging", to: "users#logging", as: "user_logging"

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  root to: "pages#home"
end
