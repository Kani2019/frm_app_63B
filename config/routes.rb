Rails.application.routes.draw do
  root to: "products#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :users do
    collection do
      get "logout", to: "users#logout"
      get "card", to: "users#card" 
      get "card_add", to: "users#card_add" 
    end
  end

  resources :products, only: [:new, :index, :show] do
    collection do
      get "buy"
    end
  end
  
end
