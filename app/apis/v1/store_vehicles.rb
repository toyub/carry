module V1
  class StoreVehicles < Grape::API

    resource :store_vehicles do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '查找车辆信息'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '车辆的id'
      end
      get ':id' do
        @store_vehicle = current_store.store_vehicles.find(params[:id])

        if @store_vehicle.blank?
          present status: {success: false, msg: "未找到相关车辆"}
        elsif @store_vehicle.store_customer.blank?
          present status: {success: false, msg: "该车辆未绑定相应客户"}
        else
          present @store_vehicle, with: ::Entities::StoreVehicle
        end
      end
    end
  end
end
