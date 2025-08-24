Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root "sessions#new"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/profile", to: "users#show"
  get '/users', to: 'users#index'

  resources :posts, only: [:new, :create, :index]
  resources :relationships, only: [:create, :destroy]

end
