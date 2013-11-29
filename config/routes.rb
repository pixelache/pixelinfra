Pixelinfra::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users , :controllers => {:registrations => "registrations"}

  
  namespace :admin do
    resources :events do
      get :autocomplete_place_name, :on => :collection
    end
    resources :festivals
    resources :nodes
    resources :pages
    resources :places
    resources :projects
    resources :subsites do
      resources :pages
    end
    resources :users    
  end
  
  resources :events
  resources :pages
  resources :users
  
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  root :to => "home#index"
end
