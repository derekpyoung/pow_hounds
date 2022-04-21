Rails.application.routes.draw do
  get 'forecasts/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/posts', to: "posts#index"
  get '/posts/:id', to: "posts#show"
  post '/posts', to: "posts#create"
  delete '/posts/:id', to: "posts#destroy"


  post '/users', to: "users#create"
  get '/users', to: "users#index"
  get '/users/:id', to: "users#show"

  get '/forecast', to: "forecasts#get_lat_long"


end
