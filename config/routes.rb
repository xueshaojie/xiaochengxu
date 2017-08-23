Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  get 'welcome/index'

  resources :articles do
    resources :comments
    get :list, on: :collection
  end

  resources :wx_users do
    get :wei_xin_login, on: :collection 
  end

  root 'welcome#index'


end
