Pixelinfra::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users , :controllers => {:registrations => "registrations"}
  themes_for_rails
  
  namespace :admin do
    resources :attendees
    resources :archivalimages do
      get :autocomplete_event_name, :on => :collection
      get :autocomplete_festival_name, :on => :collection
      get :autocomplete_project_name, :on => :collection  
    end
    resources :documenttypes
    resources :dynamictaglines
    resources :etherpads do
      get :autocomplete_event_name, :on => :collection
    end
    resources :events do
      get :autocomplete_place_name, :on => :collection
      get :autocomplete_event_name, :on => :collection      
    end
    resources :festivals do
      resources :festivalthemes
    end
    resources :festivalthemes
    resources :flickrsets do
      get :autocomplete_event_name, :on => :collection
    end
    resources :frontitems do
      post :sort, :on => :collection
      get :autocomplete_post_title, :on => :collection
      get :autocomplete_page_name, :on => :collection
    end
    resources :frontmodules
    resources :memberships
    resources :nodes
    resources :pages do
      get :options, :on => :collection
      get :autocomplete_event_name, :on => :collection
      get :autocomplete_festival_name, :on => :collection
      get :autocomplete_project_name, :on => :collection
      get :autocomplete_page_name, :on => :collection      
      post :sort, :on => :collection
      member do
        get :order
      end 
    end
    resources :places
    resources :posts do
      get :options, :on => :collection
      get :autocomplete_event_name, :on => :collection
      get :autocomplete_festival_name, :on => :collection
      get :autocomplete_project_name, :on => :collection      
      get :autocomplete_post_title, :on => :collection
    end
    resources :projectproposals do
      resources :comments
    end
    resources :projects
    resources :residencies
    resources :search
    resources :steps do
      get :autocomplete_event_name, :on => :collection
      get :autocomplete_festival_name, :on => :collection
    end
    resources :subsites do
      resources :pages
      resources :posts
    end
    resources :users    
  end
  resources :dynamictaglines
  resources :events
  resources :etherpads
  resources :festivals do
    get :attendees
    resources :posts
    member do
      get :archive
      get '/theme/:theme_id', :controller => :festivals, :action => :theme, :as => :festival_theme
      get '/*page', :action => :page, :as => :festival_page
    end
  end
  resources :archive
  resources :pages
  resources :projects do
    resources :pages do
      member do
        get '/*page', :action => :show, :as => :project_page
      end
    end
  end
  resources :publications
  resources :users do
    resources :posts
  end
  resources :nodes
  resources :posts

  resources :residencies
  resources :steps
  get '/activities' => 'home#activities'
  post '/search' => 'search#create'
  get '/pages/*id' => 'pages#show'
  get '/helsinki/*url', :controller => :application, :action => :reroute
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get '/members' => 'memberships#index', as: 'members'
  get '/member/:id' => 'memberships#show', as: 'member'
  get '/admin' => 'admin/events#index'
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, via: :get
  match   '/add_to_list', via: :post, :controller => :application, :action => :add_to_mailchimp
  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  root :to => "home#index"
end
