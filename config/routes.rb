Rails.application.routes.draw do
  root to: 'pages#home'

  resources :tasks do
    collection do
      delete :clear_status
    end
    member do
      patch :toggle_status
    end
    collection do
      get 'filter'
    end
  end

  get 'verify_tenant', to: 'tenants#verify', as: :verify_tenant
end
