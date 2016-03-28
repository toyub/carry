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
        status = AddVehicleService.call(vehicle_params, plate_params, customer_params: customer_params, customer: customer)
        present info: status.notice, customer_id: status.customer.try(:id)
      end
    end

    helpers do
      def basic_params
        params[:store_id] = current_store.id
        params[:store_chain_id] = current_store_chain.id
        params[:store_staff_id] = current_user.id
      end

      def vehicle_params
        basic_params
        vehicle = ActionController::Parameters.new(params)
        vehicle.permit(:store_id,
                       :store_chain_id,
                       :store_staff_id,
                       :vehicle_brand_id,
                       :vehicle_series_id,
                       :vehicle_model_id,
                       detail: [
                         :bought_on
                         ])
      end

      def customer_params
        vehicle = ActionController::Parameters.new(params)
        basic_params
        vehicle.permit(:first_name,
                        :last_name,
                        :phone_number,
                        :store_id,
                        :store_chain_id,
                        :store_staff_id)
      end

      def plate_params
        vehicle = ActionController::Parameters.new(params)
        basic_params
        vehicle.permit(:license_number,
                     :store_id,
                     :store_chain_id,
                     :store_staff_id)
      end
    end

  end
end
