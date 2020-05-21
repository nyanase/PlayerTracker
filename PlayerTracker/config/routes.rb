Rails.application.routes.draw do
  get 'teams/new'
  get 'teams/create'
  get 'teams/show'
  get 'teams/edit'
  get 'teams/update'
  get 'teams/destroy'
  devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'
end
