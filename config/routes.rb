Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations',
  #   confirmations: 'users/confirmations',
  #   passwords: 'users/passwords'
  # }

  get 'welcome/index'
  get 'password_resets/new'
  get 'password_resets/edit'

  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'

  resources :articles do
    resources :comments
    get :list, on: :collection
  end

  resources :wx_users do
    get :wx_login, on: :collection
  end

  root 'welcome#index'

  resources :users
  # resources :account_activations, only: [:edit]
  resources :password_resets,      only: [:new, :create, :edit, :update]

end
