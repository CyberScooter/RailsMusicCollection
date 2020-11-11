Rails.application.routes.draw do  
  #index route
  root 'home#home'
  
  #contact form routes
  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'

  #create new user routes
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  #login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :favourites, only: [:index, :create, :destroy]

  get '/favourites', to: 'favourites#index'
  post '/favourites', to: 'favourites#create'

  resources :albums

  #songs to be nested ontop of albums so songs is after albums in url
  resources :songs, :path => "/albums/:album_id/songs", :except => [:show, :edit, :update]

  #map contacts to contact, restricts to create and new
  resources :contacts, :path => "contact", only: [:create,:new]

  #maps user path to "register" allowing the user of /register routes above, restricts to create and new
  resources :users, :path => "register", only: [:create,:new] 

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
