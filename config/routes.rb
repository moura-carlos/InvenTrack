Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :items

  resources :users

  resources :categories

  get "signup", to: "users#new"

  # get "home", to: "pages#home"
  root "pages#home"
  # get "users/signup", to: "users#new"
  resource :session, only: [:new, :create, :destroy]
  # root "items#index"
end
