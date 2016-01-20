module V1
  class Customers < Grape::API

    resource :customers, desc: "客户相关" do
      before do
        authenticate_user!
      end

      add_desc "客户列表"
      params do
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer, desc: "所属门店ID"
        end
      end
      get do
        q = current_store_chain.store_customers.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::Customer
      end

      add_desc "客户详情"
      get ":id", requirements: { id: /[0-9]*/ } do
        customer = current_store_chain.store_customers.find(params[:id])
        present customer, with: ::Entities::Customer
      end
    end

  end
end
