ActionController::Routing::Routes.draw do |map|
  map.resources :participants, :except => [:new, :create]
  map.resources :sessions, :only => [:new, :create]
  map.signin '/signin', :controller => 'sessions', :action => 'new'

  map.root :controller => 'participants', :action => 'index'
end
