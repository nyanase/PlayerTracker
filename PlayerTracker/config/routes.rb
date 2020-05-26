Rails.application.routes.draw do
  resources :teams do 
    resources :games
    get '/invite', to: 'teams#invite_new'
    post '/invite', to: 'teams#invite_create'
  end
  resources :players
  resources :games

  
  devise_for :users

  get 'home/index'
  root 'home#index'
end
