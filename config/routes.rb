Rails.application.routes.draw do
  resources :wikis

  devise_for :users

  devise_scope :user do
  	get "users/show"
  	get "users/down_grade"
  end
  
  resources :users, only: [:new, :create]
  resources :charges, only: [:new, :create]

  get "welcome/index"

  root 'welcome#index'

end
