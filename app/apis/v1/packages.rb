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
        store_packages = current_store_chain.store_packages.order(params[:q][:s])
        q = store_packages.ransack(params[:q].except(:s))
        present q.result.order('id asc'), with: ::Entities::Package
      end
    end

  end
end
