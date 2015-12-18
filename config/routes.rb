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
      resource :tracking, only: [:show, :create, :update] do
        get :sections, on: :collection
        resources :tracking_sections
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

      member do
        post :checked
        get :excel
      end
    end

    resources :depots do
      member do
        get :materials
      end
    end
  end# END of namespace :kucun

  get "xiaoshou/main", to:  "xiaoshou#main"

  namespace :soa do
    resources :staff
  end

  namespace :xianchang do
    resources :field_constructions, only: [:index]
    resources :pre_orders, only: [:index]
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
    resources :depots do
      collection do
        get :fetch
      end

      member do
        put :toggle_useable
        put :prefer
        get :binding_material_count
      end
    end

    resources :material_categories do
      collection do
        get :fetch
      end
    end

    resource :organizational_structure

    resources :customer_categories do
      collection do
        get :services
      end

      member do
        get :customers
        post :change_category
      end
    end

    resource :store do
      collection do
        post :save_picture
      end
    end


    namespace :sms do
      resources :topups
      resources :switches
      resources :messages
    end

    resources :privileges

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

  resource :session, only: [:new, :create, :destroy, :edit]
  resource :password do
    collection do
      get :send_validate_code
    end
  end

  namespace :api do
    resources :store_staff, only: [:index, :update]
    resources :store_service_categories, only: [:create]
    resources :store_services, only: [:index, :show, :create, :update] do
      resources :store_service_workflows, only: [:create, :destroy, :update]
      member do
        post :save_picture
      end

      resource :store_service_settings, only: [:show, :create, :update]
      resources :store_service_reminds, only: [:update]
      resources :store_service_trackings, only: [:create, :update, :destroy]
    end
    resources :store_vehicles, only: [:index]
    resources :store_orders, only: [:index] do
      resources :complaints, only:[:new, :create]
    end
    resources :store_subscribe_orders
    resources :store_packages, only: [:show, :create, :update, :index] do
      member do
        post :save_picture
      end

      resource :store_package_settings, only: [:show, :create, :update]
      resources :store_package_trackings, only: [:create, :update, :destroy]
    end
    resources :store_customer_entities, only: [:index, :create, :update, :show] do
      collection do
        get :cities
        get :regions
      end
    end

    resource :qiniu do
      collection do
        get :upload_token
      end
    end

    resources :store_departments do
      member do
        get :children
      end
      resources :store_positions
    end

    resources :store_customer_categories

  end

  namespace :open do
    namespace :topups do
      resource :alipay do
        collection do
          post :notify_url
          get :return_url
        end
      end
    end
  end

  namespace :crm do
    resources :store_customers do
      resources :store_vehicle_archives, only: [:new, :create, :show, :edit, :update]
      resources :store_vehicle_status, only: [:show]
      resources :store_vehicle_service_records, only: [:show]
      resources :expense_records, only: [:index]
    end
  end

  root 'kucun/materials#index'

  mount Sidekiq::Web => '/sidekiq'

end
