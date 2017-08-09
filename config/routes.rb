Rails.application.routes.draw do
  get 'welcome/index'
  resources :articles do
    resources :comments
  end
  root 'welcome#index'

  namespace :api do
    resources :articles
  end
end
