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
    end
  end
end
