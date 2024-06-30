Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :achievements
  default_url_options host: ENV.fetch('HOST', 'localhost:3000')

  ActiveAdmin.routes(self)
  root to: 'pages#home'

  resources :tasks do
    member do
      patch :toggle_status
    end
    collection do
      get 'filter'
    end
  end
  resources :calender, only: [:index] do
    collection do
      get :week
      get :month
    end
  end
  resources :achievements
end
