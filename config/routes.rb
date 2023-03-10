Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :items

  resources :users

  get "signup", to: "users#new"
  # get "users/signup", to: "users#new"
end
