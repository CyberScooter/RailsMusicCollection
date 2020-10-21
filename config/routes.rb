Rails.application.routes.draw do
  get 'contact/new'
  get '/contact', to: 'contact#new'
  post '/contact', to: 'contact#create'

  root 'home#home'
  
  resources :contacts, :path => "contact"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
