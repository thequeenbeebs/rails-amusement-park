Rails.application.routes.draw do
  root "users#home"
  resources :users, only: [:new, :index, :create, :show]
  resources :attractions, only: [:index, :show, :new, :create, :edit, :update]
  post '/attractions/:id', to: 'attractions#ride'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
