Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cart, only: %i[create destroy index]
  resources :products, only: %i[show index]
  root to: "products#index"
end
