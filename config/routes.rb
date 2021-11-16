Project::Application.routes.draw do
  
  resources :dashboards

  root :to => redirect('/dashboards')


  get '/login' , to: 'sessions#login'
  post '/login' , to: 'sessions#create'
  post '/logout' , to: 'sessions#destroy'
  get '/logout' , to: 'sessions#destroy'

  get '/schedule', :controller => 'employees', :action => 'show'
  
  resources :admin
end
