ActionController::Routing::Routes.draw do |map|
  map.resources :participants, :except => [:new, :create]
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.resources :contributions
  map.resources :issues, :except => [:show, :destroy]
  map.signin '/signin', :controller => 'sessions', :action => 'new'
  map.signout '/signout', :controller => 'sessions', :action => 'destroy'
  map.root :controller => 'participants', :action => 'index'
end
