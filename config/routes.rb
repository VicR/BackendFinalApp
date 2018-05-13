Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'admin_auth', skip: [:omniauth_callbacks], controllers: {
    registrations:  'overrides/registrations',
    sessions: 'overrides/sessions',
    token_validations:  'overrides/token_validations'
  }
  as :user do
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    post '/users', to: 'users#create'
    put '/users/:id', to: 'users#update'
    delete '/users/:id', to: 'users#destroy'
  end

  # +Product+ routes
  resources :products, only: [:show, :index, :create, :update, :destroy]

  # +Characteristic+ routes
  resources :characteristics, only: [:show, :index, :create, :update, :destroy]

  # +Provider+ routes
  resources :providers, only: [:show, :index, :create, :update, :destroy]

  # +Client+ routes
  resources :clients, only: [:show, :index, :create, :update, :destroy]

  # +ProductAdquisition+ routes
  resources :product_adquisitions, only: [:show, :index, :create, :update, :destroy]

  # +ProductSale+ routes
  resources :product_sales, only: [:show, :index, :create, :update, :destroy]

  # +Fabricator+ routes
  resources :fabricators, only: [:show, :index, :create, :update, :destroy]

  # +HighTechProduct+ routes
  resources :high_tech_products, only: [:show, :index, :create, :update, :destroy]

  # +RentProduct+ routes
  resources :rent_products, only: [:show, :index, :create, :update, :destroy]

  # +ClientPrinter+ routes
  resources :client_printers, only: [:show, :index, :create, :update, :destroy]

  # +ClientService+ routes
  resources :client_services, only: [:show, :index, :create, :update, :destroy]
end
