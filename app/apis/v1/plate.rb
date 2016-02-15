module V1
  class Plate < Grape::API

    resource :plates, desc: "车牌搜索用户" do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc "车牌搜索用户"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :q, type: Hash, default: {} do
          optional :license_number_cont, type: String, desc: "车牌"
        end
      end

      get do
        q = current_store_chain.plates.ransack(params[:q])
        plates = q.result.order('id asc')
        present plates, with: ::Entities::VehiclePlate
      end

    end
  end
end
