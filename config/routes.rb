Rails.application.routes.draw do

  mount MisAPI, at: "/" # API

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

      resources :material_inventories, only: [] do
        collection do
          get :income_records
        end
      end

      resources :outings, obly: [] do
        get :outgo_records, on: :collection
      end

      resource :saleinfo do
        resources :saleinfo_services
      end
      resource :tracking, only: [:show, :edit, :create, :update] do
        get :sections, on: :collection
        resources :tracking_sections
      end

      resources :material_sales
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
    resources :temporary_material_orders do
      resources :material_orders
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

    namespace :purchase do
      resources :receipts
    end
  end# END of namespace :kucun

  get "xiaoshou/main", to:  "xiaoshou#main"

  namespace :mkis do
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
      resource :tracking, only: [:show, :edit, :create, :update] do
        get :sections, on: :collection
        resources :tracking_sections
      end
      resources :material_sales
    end
  end
  resources :xiaoshou

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
      resources :performs, only: [:index, :show] do
        get "search", on: :collection
      end
    end
    resources :events, only: :index
    resources :protocols do
      get 'record', on: :member
    end
    resources :performance, only: :index do
      get 'search', on: :collection
    end
    resources :salaries do
      get "record", on: :collection
      get 'search', on: :collection
      get 'confirm', on: :member
      get 'check', on: :member
    end
  end

  namespace :ais do
    resources :incomes, only: [:index]
    resources :costs, only: :index
    resources :categories, only: [:show] do
      resources :order_items, only: [:index]
    end
    resources :material_orders, only: [:index, :show, :update]
    resources :reports, only: :index
  end

  namespace :xianchang do
    resources :groups, only: [:index]
    resources :store_workstations, only: [:index, :new, :create, :edit, :update] do
      member do
        put :finish
        put :perform
        put :exchange
        put :start
      end
    end
    resources :store_orders, only: [:show, :update] do
      member do
        put :terminate
        put :execute
        put :pause_in_queuing_area
        put :pause_in_workstation
        put :pause
        put :play
      end
    end
    resources :store_workflows, only: [:edit, :update] do
      get :free_mechanics, on: :member
    end
  end

  namespace :sas do
    resources :sells, only: [:index] do
      get "report", on: :collection
    end
    resources :customers, only: [:index]
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
    resources :sms_captchas do
      collection do
        post :validate
      end
    end
  end# End of Ajax

  #Api
  namespace :api do
    namespace :home do
      resources :staff_todos do
        collection do
          get :clear_done
        end
      end
      resource :staff_shortcuts
      resources :schedules do
        get :search, on: :collection
      end

      namespace :notifications do
        resources :work_reminders
        resources :system_bulletins
        resources :calendar_schedule_reminders
        resources :tracking_reminders
        resources :counters
        resources :envelopes
      end
      resources :shortcuts, only:[:index]
    end

    resources :store_materials, only: :index
    resources :store_temporary_items, only: [:index, :show]
    resources :consumable_store_materials, only: :index
    resources :store_material_categories, only: :index

    #Order
    namespace :order do

      resources :login do
        collection do
          post :login
        end
      end

      resources :orders do
        collection do
        end
      end

      resources :store_vehicles do
        collection do
          post :add_vehicle
          get :search
        end
      end

      resources :store_materials do
        collection do
          get :material_name
        end
      end

      resources :store_services do
        collection do
          get :service_name
        end
      end

      resources :store_packages

      resources :categories do
        collection do
          get :sale_category, :service_category
        end
      end

    end
    #Order end

    resources :sale_categories, only: :index
    resources :store_staff, only: [:index, :update] do
      get 'check_phone', on: :collection
    end
    resources :store_operators, only: [:index, :update]
    resources :store_service_categories, only: [:create]
    resources :store_services, only: [:index, :show, :create, :update] do
      resources :store_service_workflows, only: [:create, :destroy, :update]
      member do
        post :save_picture
      end
      collection do
        get :search
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

    resources :store_orders do
      collection do
        post :draft
      end
      member do
        put :update_draft
        patch :update_draft
      end
      resources :complaints, only:[:new, :create]
    end
    resources :subscribe_orders
    resources :recommended_orders

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

    resources :store_material_saleinfos, only: [:index] do
      collection do
        get :search
      end
    end

    resources :store_customer_accounts do
      member do
        post :expense
      end
    end

    namespace :sas do
      resources :stores, only: [] do
        resources :customer_gender, only: [:index]
        resources :customers, only: [:index]
        resources :customer_consuming, only: [:index]
        resources :consuming_week, only: [:index]
        resources :sales, only: [:index] do
          get 'payments', on: :collection
          get 'categories', on: :collection
          get 'days', on: :collection
        end
        resources :sale_top, only: [:index]
        resources :vehicles, only: [:index]
        resources :vehicle_brand, only: [:index]
      end
    end

    namespace :osm do
      resources :groups
      resources :staff
    end

    resources :recommended_orders
    resources :subscribe_orders

    resources :vehicle_brands, only: [:index] do
      resources :vehicle_manufacturers, only: [:index]
    end

    resources :vehicle_manufacturers, only: [] do
      resources :vehicle_series, only: [:index]
    end

    resources :vehicle_series, only: [] do
      resources :vehicle_models, only: [:index]
    end

    namespace :pos do
      namespace :products do
        resources :materials
        resources :packages
        resources :services
      end

      namespace :carts do
        resources :orders do
          resources :items
        end
      end

      namespace :auth do
        resources :discount_authorities
        resources :waste_order_authorities
      end

      namespace :cashier do
        resources :orders
      end

      namespace :zidingyi do
        resources :store_materials
      end

    end

    namespace :crm do
      resources :customers do
        get 'check', on: :collection
        resources :vehicles
        resources :assets
      end
    end

    resources :store_commission_templates, only: [:show]

  end#End of api

  namespace :pos do
    namespace :cashier do
      resources :checkouts
    end
    resources :store_orders
    resources :recommended_orders
    resources :subscribe_orders
  end

  namespace :printer do
    namespace :pos do
      resources :orders
    end
    namespace :ais do
      resources :material_orders, only: :show
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
      resources :complaints, only: [:index, :edit, :update]
      resources :store_trackings, only: [:index, :create]
      resources :store_repayments, only: [:index, :create] do
        collection do
          get :finished, :hanging
        end
      end
      resources :store_assets, only: [:index, :show] do
        resources :store_asset_items, only: [:show]
      end
    end
  end

  namespace :srm do
    get "material_orders/nowaus", controller: 'material_orders', action: 'nowaus', as: :nowaus
    resources :material_orders
    resources :store_suppliers do
      collection do
        get :add
      end
      resources :material_orders
      resources :assessments, controller: 'store_supplier_assessments'
    end
  end

  namespace :receipt do
    namespace :pos do
      resources :orders
    end
  end

  resource :session, only: [:new, :create, :destroy, :edit]
  resource :password do
    collection do
      get :send_validate_code
    end
  end

  namespace :import do
    resources :materials
  end

  root 'home#show'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == SIDEKIQ[:username] && password == SIDEKIQ[:password]
  end if (Rails.env.production? || Rails.env.staging?)
  mount Sidekiq::Web => '/sidekiq'

end
