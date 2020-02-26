Rails.application.routes.draw do
  root to: "products#new"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: :new
  resources :users
end
