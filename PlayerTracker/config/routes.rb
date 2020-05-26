Rails.application.routes.draw do
  get 'games/show'
  get 'players/show'
  resources :teams do 
    resources :games
  end
  resources :players
  resources :games
  
  devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'
end
