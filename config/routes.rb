Rails.application.routes.draw do
  resources :wikis

  devise_for :users
  resources :users, only: [:new, :create]
  resources :charges, only: [:new, :create]

  get "welcome/index"

  root 'welcome#index'

end
