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
      get 'store_vehicles/:id' do
        @store_vehicle = current_store.store_vehicles.find(params[:id])
        present @store_vehicle, with: ::Entities::StoreVehicle
      end
    end
  end
end
