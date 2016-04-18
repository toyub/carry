module V1
  class Vehicles < Grape::API

    before do
      authenticate_platform!
      authenticate_user!
    end

    resource :vehicles do
      resource :brands do
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
        end
        add_desc "车品牌"
        get do
          present VehicleBrand.all, with: ::Entities::VehicleBrand
        end
      end

      resource :manufacturers do
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
          requires :vehicle_brand_id, type: Integer, desc: "车品牌的id"
        end
        add_desc "车辆制造商"
        get do
          manufacturers = VehicleManufacturer.by_brand(params[:vehicle_brand_id])
          present manufacturers, with: ::Entities::VehicleBrand, type: :manufacturer
        end
      end

      resource :series do
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
          requires :vehicle_manufacturer_id, type: Integer, desc: "制造商的id"
        end
        add_desc "车系"
        get do
          series = VehicleSeries.by_manufacturer(params[:vehicle_manufacturer_id])
          present series, with: ::Entities::VehicleBrand
        end
      end

      resource :models do
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
          requires :vehicle_series_id, type: Integer, desc: '所属车系的id'
        end
        add_desc "车型"
        get do
          models = VehicleModel.by_series(params[:vehicle_series_id])
          present models, with: ::Entities::VehicleBrand
        end
      end

      add_desc "添加车辆"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :license_number, type: String, desc: '车牌号'
        optional :first_name, type: String, desc: '名字'
        optional :last_name, type: String, desc: '姓'
        optional :phone_number, type: Integer, desc: '客户电话号码'
        optional :vehicle_brand_id, type: Integer, desc: '品牌'
        optional :vehicle_series_id, type: Integer, desc: '车系'
        optional :vehicle_model_id, type: Integer, desc: '车型'
        optional :detail, type: Hash, default: {} do
          optional :bought_on, type: DateTime, desc: '购买年份'
        end
      end
      post do
        status = AddVehicleService.call(current_store, vehicle_params, customer_params)
        present info: status.notice, customer_id: status.customer.try(:id), vehicle_id: status.vehicle.try(:id)
      end
    end

    helpers do
      def wild_params
        @basic_params ||= {
          store_id: current_store.id,
          store_chain_id: current_store_chain.id,
          store_staff_id: current_user.id
        }
        @wild_params ||= ActionController::Parameters.new(@basic_params.merge(params))
      end

      def vehicle_params
        wild_params.permit :store_id,
                           :store_chain_id,
                           :store_staff_id,
                           :vehicle_brand_id,
                           :vehicle_series_id,
                           :vehicle_model_id,
                           :license_number,
                           detail: [:bought_on]
      end

      def customer_params
        wild_params.permit :first_name,
                           :last_name,
                           :phone_number,
                           :store_id,
                           :store_chain_id,
                           :store_staff_id
      end
    end

  end
end
