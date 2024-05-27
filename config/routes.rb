Rails.application.routes.draw do
  root to: 'pages#home'

  resources :tasks do
    member do
      patch :toggle_status
    end
    collection do
      get 'filter'
    end
  end
  resources :calender
end
