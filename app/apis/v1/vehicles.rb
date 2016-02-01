module V1
  class Vehicles < Grape::API

    before do
      authenticate_user!
    end

    resource :vehicles do
      resource :brands do
        add_desc "车品牌"
        get do
          present VehicleBrand.all, with: ::Entities::VehicleBrand
        end
      end

      resource :series do
        params do
          optional :vehicle_brand_id, type: Integer, desc: "所属品牌ID"
        end
        add_desc "车系"
        get do
          series = VehicleSeries.where(vehicle_brand_id: params[:vehicle_brand_id])
          present series, with: ::Entities::VehicleBrand
        end
      end

      resource :models do
        params do
          optional :vehicle_series_id, type: Integer, desc: '所属车系的id'
        end
        add_desc "车型"
        get do
          models = VehicleModel.where(vehicle_series_id: params[:vehicle_series_id])
          present models, with: ::Entities::VehicleBrand
        end
      end

      add_desc "添加车辆"
      params do
        requires :license_number, type: String, desc: '车牌号'
        requires :first_name, type: String, desc: '名字'
        requires :last_name, type: String, desc: '姓'
        requires :phone_number, type: Integer, desc: '客户电话号码'
        optional :vehicle_brand_id, type: Integer, desc: '品牌'
        optional :vehicle_series_id, type: Integer, desc: '车系'
        optional :vehicle_model_id, type: Integer, desc: '车型'
        optional :detail, type: Hash, default: {} do
          optional :bought_on, type: DateTime, desc: '购买年份'
        end
      end
      post do
        customer = StoreCustomer.where(phone_number: params[:phone_number]).last
        status = AddVehicleForIpadService.call(vehicle_params, plate_params, customer_params: customer_params, customer: customer)
        state = 1 if status.success?
        present state, info: status.notice
      end
    end

    helpers do
      def vehicle_params
        declared(except_other_with_vehicle, include_missing: false).merge(
          store_id: current_store.id,
          store_chain_id: current_store_chain.id,
          store_staff_id: current_user.id
        )
      end

      def except_other_with_vehicle
        params.except(:first_name, :last_name, :phone_number, :license_number, :json)
      end

      def customer_params
        declared(except_other_with_customers, include_missing: false).merge(
          store_id: current_store.id,
          store_chain_id: current_store_chain.id,
          store_staff_id: current_user.id
        )
      end

      def except_other_with_customers
        params.except(:license_number,
                      :json,
                      :vehicle_brand_id,
                      :vehicle_series_id,
                      :vehicle_model_id,
                      :detail
                        )
      end

      def plate_params
        declared(except_other_with_plate, include_missing: false).merge(
          store_id: current_store.id,
          store_chain_id: current_store_chain.id,
          store_staff_id: current_user.id
        )
      end

      def except_other_with_plate
        params.except(:first_name,
                      :last_name,
                      :phone_number,
                      :json,
                      :vehicle_brand_id,
                      :vehicle_series_id,
                      :vehicle_model_id,
                      :detail
                      )
      end
    end

  end
end
