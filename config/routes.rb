Project::Application.routes.draw do
  get '/restday/:id(.:format)' , :controller => 'dashboards', :action => 'dayoff' , as: 'dayoff'
  post '/restday/:id(.:format)' , :controller => 'dashboards', :action => 'dayoff' 

  resources :dashboards
  

  root :to => redirect('/dashboards')

  get '/login' , to: 'sessions#login'
  post '/login' , to: 'sessions#create'
  post '/logout' , to: 'sessions#destroy'
  get '/logout' , to: 'sessions#destroy'

  get '/schedule', :controller => 'employees', :action => 'show'
  
  resources :admin

end
