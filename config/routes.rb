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
        resources :saleinfo_services
      end
      resource :commission
      resource :tracking
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
    resources :material_saleinfo_categories

    resources :material_inventories

    get "material_orders/nowaus", controller: 'material_orders', action: 'nowaus', as: :nowaus
    resources :material_orders
    resources :store_suppliers do
      collection do
        get :add
      end
      resources :material_orders
      resources :assessments, controller: 'store_supplier_assessments'
    end
    resources :outings
    namespace :transfer do
      resources :pickings
      resources :receipts
    end
    resources :checkins
    resources :returnings
    resources :shrinkages
    resources :physical_inventories do
      collection do
        get :review
        post :loss_report
        post :profit_report
      end
    end

    resources :depots do
      member do
        get :materials
      end
    end
  end# END of namespace :kucun

  namespace :xiaoshou do
    namespace :service do
      resources :profiles, only: [:index, :show, :create]
      resources :settings, only: [:edit, :show, :update] do
        member do
          get :modify
        end
        resources :workflows, only: :show
      end
      resources :categories, only: [:create]
    end
  end

  namespace :soa do
    resources :staff
  end

  namespace :xianchang do
    resources :field_constructions, only: [:index]
  end

  namespace :settings do
    namespace :settlements do
      resources :accounts do
        member do
          patch :toggle_status
        end
      end
    end
    resources :commission_templates
  end

  namespace :ajax do
    resources :store_material_categories, only: [] do
      member do
        get :sub_categories
      end
    end

    resources :store_materials, only: [:index] do
      collection do
        get :inventories
      end
    end
    resources :store_workstation_categories, only: [] do
      resources :store_workstations, only: [:index]
    end
    resource :geo, only: [:show] do
      get "/:country_code/states/", to: "geos#states", as: :country_states
      get "/:country_code/states/:state_code/cities", to: "geos#cities", as: :country_state_cities
    end
    resources :store_suppliers, only: [:index]
  end

  resource :session, only: [:new, :create, :destroy]

  namespace :api do
    resources :store_service_categories, only: [:create]
    resources :store_services, only: [:index, :show, :create, :update] do
      resources :store_service_workflows, only: [:create, :destroy, :update]
      member do
        post :save_picture
      end

      resource :store_service_settings, only: [:show, :create, :update]
      resources :store_service_reminds, only: [:update]
    end
  end

  root 'kucun/materials#index'

  mount Sidekiq::Web => '/sidekiq'

end
