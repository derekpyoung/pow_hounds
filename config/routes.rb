Rails.application.routes.draw do
  get 'forecasts/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: "posts#index"
  get '/posts', to: "posts#index"
  get '/posts/:id', to: "posts#show"
  post '/posts', to: "posts#create"
  delete '/posts/:id', to: "posts#destroy"


  post '/users', to: "users#create"
  patch 'users/:id', to: "users#update"
  get '/users', to: "users#index"
  get '/users/:id', to: "users#show"
  get '/users/:id/posts', to: "posts#users_posts"

  get '/forecast', to: "forecasts#snow_inches" #snow in inches
  post 'forecast', to: "forecasts#snow_inches"
  get '/threeDay', to: "forecasts#threeDay" #3 day summery 

  post '/sessions', to: "sessions#create"

  get '/current', to: "posts#current"

  get '/userposts/:id', to: "users#posts"

  get '/home', to: "users#home"


end
