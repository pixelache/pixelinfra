Pixelinfra::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users , :controllers => {:registrations => "registrations"}
  themes_for_rails
  
  namespace :admin do
    resources :dynamictaglines
    resources :etherpads
    resources :events do
      get :autocomplete_place_name, :on => :collection
    end
    resources :festivals
    resources :flickrsets do
      get :autocomplete_event_name, :on => :collection
    end
    resources :frontitems do
      post :sort, :on => :collection
    end
    resources :frontmodules
    resources :nodes
    resources :pages do
      get :options, :on => :collection
    end
    resources :places
    resources :posts do
      get :options, :on => :collection
      get :autocomplete_event_name, :on => :collection
      get :autocomplete_festival_name, :on => :collection
      get :autocomplete_project_name, :on => :collection            
    end
    resources :projects
    resources :search
    resources :subsites do
      resources :pages
      resources :posts
    end
    resources :users    
  end
  
  resources :dynamictaglines
  resources :events

  resources :festivals
  resources :pages
  resources :projects
  resources :users
  resources :nodes
  resources :posts
  
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get '/admin' => 'admin/posts#index'
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, via: :get
  
  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  root :to => "home#index"
end
