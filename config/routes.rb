ChillAndGrill::Application.routes.draw do
  root :to => 'pages#home'
  resources :users do
    post 'approve', :on => :member
  end
  resources :events do
    resources :rsvps, :only => [:show, :new, :create, :edit, :update]
    post 'remind', :on => :member
  end
  resource :session, :controller => "session", :only => [:new, :create, :destroy]
  match 'about' => "pages#about"
end
