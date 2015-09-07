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
    resources :documents
    resources :documenttypes
    resources :dynamictaglines
    resources :etherpads do
      get :autocomplete_event_name, :on => :collection
    end
    resources :events do
      member do
        get :attendees
      end
      get :autocomplete_place_name, :on => :collection
      get :autocomplete_event_name, :on => :collection      
    end
    resources :festivals do
      member do
        get :subscribe
        get :unsubscribe
        get :toggle_list
        post :subscribe_other
        post :unsubscribe_other
      end
      resources :festivalthemes do
        resources :experiences
      end
      
    end
    resources :festivalthemes
    
    resources :flickrsets do
      get :autocomplete_event_name, :on => :collection
    end
    resources :frontitems do
      post :sort, :on => :collection
      get :autocomplete_post_title, :on => :collection
      get :autocomplete_page_name, :on => :collection
      get :autocomplete_event_name, on: :collection
      get :autocomplete_project_name, on: :collection
      get :autocomplete_festival_name, on: :collection
      get :autocomplete_residency_name, on: :collection
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
      member do
        get :attendees
      end
      get :options, :on => :collection
      get :autocomplete_event_name, :on => :collection
      get :autocomplete_festival_name, :on => :collection
      get :autocomplete_project_name, :on => :collection      
      get :autocomplete_post_title, :on => :collection
    end
    resources :projectproposals do
      resources :comments
    end
    resources :projects do
      member do
        get :subscribe
        get :unsubscribe
        get :toggle_list
        post :subscribe_other
        post :unsubscribe_other
      end
    end
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
  resources :events do
    resources :attendees
  end
  resources :etherpads
  resources :festivals do
    get :attendees
    resources :posts
    resources :events
    resources :attachments, as: :publications
    resources :festivalthemes do
      resources :experiences
    end
    member do
      get :archive
      get '/theme/:theme_id', :controller => :festivals, :action => :theme, :as => :festival_theme
      get '/theme/:theme_id/activities', :controller => :experiences, :action => :index, :as => :festival_theme_activities
      get '/*page', :action => :page, :as => :festival_page
    end
  end
  resources :archive do
    resources :posts
    resources :events
  end
  
  resources :pages
  
  resources :projects do
    resources :posts
    resources :events
    resources :attachments, as: :publications
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
  resources :posts do
    resources :attendees
  end

  resources :residencies do
    resources :posts
    resources :events
  end
  
  resources :feeds
  resources :steps
  
  get '/activities' => 'home#activities'
  post '/search' => 'search#create'
  get '/pages/*id' => 'pages#show'
  get '/news' => 'posts#index'
  get '/helsinki/feed' => 'feeds#index', :defaults => { :format => 'rss' }
  get '/helsinki/*url', :controller => :application, :action => :reroute
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/feed' => 'feeds#index', :defaults => { :format => 'rss' }
  get '/auth/failure' => 'sessions#failure'
  get '/members' => 'memberships#index', as: 'members'
  get '/members/feed' => 'memberships#feed', as: 'member_feeds'
  get '/member/:id' => 'memberships#show', as: 'member'
  get '/member/:member_id/feed' => 'memberships#feed', as: 'member_feed'
  post '/member/:id/contact' => 'memberships#contact', as: 'contact_member'
  get '/admin' => 'admin/events#index'
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, via: :get
  match   '/add_to_list', via: :post, :controller => :application, :action => :add_to_mailchimp
  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  root :to => "home#index"
  get '*unmatched_route', to: 'application#not_found'
end
