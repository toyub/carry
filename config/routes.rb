Rails.application.routes.draw do

  require 'sidekiq/web'

  #Kucun
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
    resources :staff do
      resource :setting do
       patch 'adjust', on: :member
       patch 'password', on: :member
      end
      resources :events  do
        get 'detail', on: :member
        get 'search', on: :collection
      end
      resources :record, only: :index do
        get "search", on: :collection
      end
    end
    resources :events, only: :index
    resources :protocols do
      get 'record', on: :member
    end
    resources :performance do
      get 'search', on: :collection
    end
    resources :salaries do
      get "record", on: :collection
      get 'search', on: :collection
      get 'confirm', on: :member
      get 'check', on: :member
    end
  end

  namespace :xianchang do
    resources :field_constructions, only: [:index]
    resources :schedule_personals, only: [:index]
    resources :workstations, only: [:index]
  end

  #Settings
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

  end #End of namespace :settings

  #Ajax
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
  end # End of Ajax

  # 总部平台api调用
  namespace :erp do
    resources :customers, only: [:index]
  end #End of erp

  #Api
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
    resources :store_vehicles, only: [:index, :show] do
      collection do
        get :search
      end
    end

    resources :store_orders, only: [:index, :show] do
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

    resources :tags, only: [:create]

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
    resources :store_checkouts
  end


  namespace :pos do
    namespace :cashier do
      resources :checkouts
    end
    resources :store_orders
    resources :pre_orders, only: [:index]
  end

  namespace :printer do
    namespace :pos do
      resources :orders
    end
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
      resources :store_vehicles, only: [:new, :create, :show, :edit, :update]
      resources :vehicle_conditions, only: [:show]
      resources :vehicle_services, only: [:show]
      resources :expense_records, only: [:index]
      resources :pre_orders, only: [:index]
      resources :complaints, only: [:index, :edit, :update]
      resources :store_trackings, only: [:index, :create]
      resources :store_repayments
    end
  end


  root 'kucun/materials#index'

  mount Sidekiq::Web => '/sidekiq'

end
