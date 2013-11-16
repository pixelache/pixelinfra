Pixelinfra::Application.routes.draw do
  devise_for :users , :controllers => {:registrations => "registrations"}

  
  namespace :admin do
    resources :users
    resources :subsites
    resources :events
  end
  
  resources :users
  
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  root :to => "home#index"
end
