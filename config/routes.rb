Project::Application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dashboards
  root :to => redirect('/dashboards')


  get '/login' , to: 'sessions#login'
  post '/login' , to: 'sessions#create'
  post '/logout' , to: 'sessions#destroy'
  get '/logout' , to: 'sessions#destroy'


end
