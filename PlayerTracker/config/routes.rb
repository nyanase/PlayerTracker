Rails.application.routes.draw do
  resources :teams do 
    resources :games
    get '/invite', to: 'teams#invite_new'
    post '/invite', to: 'teams#invite_create'
  end
  resources :players
  resources :games do
    get '/players/:player_id/track', to: 'tracker#track', as: 'track'
  end

  post '/create_tracks', to: 'tracker#create'
  
  devise_for :users

  get 'home/index'
  root 'home#index'
end
