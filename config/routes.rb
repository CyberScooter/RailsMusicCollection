Rails.application.routes.draw do
  #contact form routes
  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'

  #create new user routes


  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  

  #index route
  root 'home#home'
  
  #map contacts to contact, restricts to create and new
  resources :contacts, :path => "contact", only: [:create,:new]

  #maps user path to register allowing the user of /register routes above, restricts to create and new
  resources :users, :path => "register", only: [:create,:new]

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
