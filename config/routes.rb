ActionController::Routing::Routes.draw do |map|
  map.resources :participants
  map.signup '/signup', :controller => 'participants', :action => 'new'  
end
