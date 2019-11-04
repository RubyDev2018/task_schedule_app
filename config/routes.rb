Rails.application.routes.draw do
  root to: 'tasks#index'
  get 'login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # resources
  namespace :admin do
    resources :users
  end
  resources :users
  resources :tasks
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
    post :import, on: :collection
    resource :favorites, only: [:create, :destroy]
  end
end
