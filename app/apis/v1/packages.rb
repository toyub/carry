module V1
  class Packages < Grape::API
    resource :packages do
      before do
        authenticate_user!
      end

      add_desc '套餐列表'

      params do
        optional :q, type: Hash, default: {} do
          optional :name_cont, type: String
          optional :store_id_eq, type: Integer
          optional :retail_price_gteq, type: Float
          optional :retail_price_lteq, type: Float
          optional :created_at_gteq, type: String
          optional :s, type: String
        end
      end

      get do
        q = current_store_chain.store_packages.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::Package
      end
    end

  end
end
