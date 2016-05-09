module V1
  class Xianchang::StoreOrder < Grape::API

    resource 'xianchang', desc: "订单施工信息" do
      before do
        # authenticate_platform!
        # authenticate_user!
      end

      add_desc "订单施工信息"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: String, desc: '订单id'
      end
      get 'store_orders/:id' do
        @store_order = current_store.store_orders.available.find(params[:id])
        present @store_order, with: ::Entities::Xianchang::StoreOrder
      end
    end
  end
end
