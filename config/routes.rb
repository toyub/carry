Rails.application.routes.draw do

  require 'sidekiq/web'

  namespace :kucun do
    get '/', to: 'materials#index'
    resources :materials do
      collection do
        get :autocomplete_name
      end
      member do
        post :save_picture
      end

      resource :saleinfo do
        resources :material_services
      end

      resource :commission do
        resources :material_commissions
      end

      resource :tracking do
      end
    end

    resources :material_units
    resources :material_brands
    resources :material_manufacturers
    resources :material_categories do
      member do
        get :add_sub_category
        get :sub_categories
      end
    end

    resources :material_inventories
    resources :material_orders
    resources :store_suppliers
  end

  resource :session, only: [:new, :create, :destroy]

  root 'kucun/materials#index'

  mount Sidekiq::Web => '/sidekiq'

end
