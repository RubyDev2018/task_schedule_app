Rails.application.routes.draw do

  root to: 'tasks#index'
  get 'login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'signup'  => 'users#new'
  # resources
  namespace :admin do
    resources :users
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :tasks
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
    post :import, on: :collection
  end
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
