module V1
  class StoreWorkstation < Grape::API
    before do
      authenticate_platform!
      authenticate_user!
    end

    resource :store_workstations do
      add_desc '工位相关'
      params do
        requires :platform, type: String, desc: '调用平台!'
      end
      get do
        stations = current_store.workstations
        present stations, with: ::Entities::WorkStation
      end

      resource :services do
        add_desc '施工中的信息'
        params do
          requires :platform, type: String, desc: '调用平台！'
          requires :order_id, type: Integer, desc: '订单的ID'
        end
        get do
          order = StoreOrder.find(params[:order_id])
          present order.store_service_snapshots, with: ::Entities::ServiceInWorkstation
        end
      end

    end

  end
end
