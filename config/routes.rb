Project::Application.routes.draw do
  
  resources :dashboards

  root :to => redirect('/dashboards')


  get '/login' , to: 'sessions#login'
  post '/login' , to: 'sessions#create'
  post '/logout' , to: 'sessions#destroy'
  get '/logout' , to: 'sessions#destroy'

  get '/schedule', :controller => 'employees', :action => 'show'

  get '/admin', :controller => 'admin', :action => 'index'
  get '/admin/create_employee', :controller => 'admin', :action => 'create_employee'
  post '/admin/create_employee', :controller => 'admin', :action => 'create_employee'
  get '/admin/create_leader', :controller => 'admin', :action => 'create_leader'
  post '/admin/create_leader', :controller => 'admin', :action => 'create_leader'

end
