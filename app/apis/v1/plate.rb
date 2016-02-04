module V1
  class Plate < Grape::API

    resource :plates, desc: "车牌搜索用户" do
      before do
        authenticate_user!
      end

      add_desc "车牌搜索用户"
      params do
        optional :q, type: Hash, default: {} do
          optional :license_number_cont, type: String, desc: "车牌"
        end
      end

      get do
        q = current_store_chain.plates.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::VehiclePlate
      end

    end
  end
end
