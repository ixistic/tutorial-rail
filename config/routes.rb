Rails.application.routes.draw do
  resources :rentals
  devise_for :users
  devise_for :installs
  resources :users
  resources :roles
  resources :authors
  resources :books
  get 'site/index'

  resources :publishers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'site#index'
end
