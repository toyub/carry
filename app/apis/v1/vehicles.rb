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
        requires :store_id, type: Integer, desc: '门店的id'
        requires :store_chain_id, type: Integer, desc: '总店的id'
        requires :store_staff_id, type: Integer, desc: '管理员的id'
        requires :license_number, type: String, desc: '车牌号'
        requires :first_name, type: String, desc: '名字'
        requires :last_name, type: String, desc: '姓'
        requires :phone_number, type: Integer, desc: '客户电话号码'
        optional :bought_on, type: DateTime, desc: '购买年份'
        optional :vehicle_brand_id, type: Integer, desc: '品牌'
        optional :vehicle_series_id, type: Integer, desc: '车系'
        optional :vehicle_model_id, type: Integer, desc: '车型'
      end
      post do
        binding.pry
        customer = StoreCustomer.where(phone_number: params[:phone_number]).last
        status = AddVehicleForIpadService.call(Vehicles.vehicle_params,Vehicles.plate_params, Vehicles.customer_params, customer: customer)
        state = 1 if status.success?
        present state, info: status.notice
      end

    end
    private
    def self.vehicle_params
      self.basic_params
      params[:detail] = {}
      params[:detail][:bought_on] = params[:bought_on]
      params.permit(
        :store_id,
        :store_chain_id,
        :store_staff_id,
        :store_customer_id,
        :vehicle_brand_id,
        :vehicle_model_id,
        :vehicle_series_id,
        detail: [
          :bought_on
        ]
      )
    end

    def self.basic_params
      params[:store_id] = APIHelpers::current_store.id
      params[:store_chain_id] = APIHelpers::current_store.store_chain_id
      params[:store_staff_id] = current_user.id
    end

    def self.customer_params
      self.basic_params
      params.permit(
        :store_id,
        :store_chain_id,
        :store_staff_id,
        :first_name,
        :last_name,
        :phone_number
      )
    end

    def self.plate_params
      self.basic_params
      params.permit(
      :store_id,
      :store_chain_id,
      :store_staff_id,
      :license_number,
      :store_customer_id
      )
    end

  end
end
