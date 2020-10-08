Rails.application.routes.draw do
  devise_for :users

  get "collaborators/new"
  get "collaborator/new"
  
  resources :wikis
  resources :collaborators, only: [:new, :create, :destroy]

  devise_scope :user do
  	get "users/show"
  	get "users/down_grade"
  end
  
  resources :users, only: [:new, :create]
  resources :charges, only: [:new, :create]

  get "welcome/index"
  root 'welcome#index'

end
