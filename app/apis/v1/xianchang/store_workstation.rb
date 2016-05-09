module V1
  class Xianchang::StoreWorkstation < Grape::API

    resource 'xianchang', desc: "现场施工管理" do
      before do
        # authenticate_platform!
        # authenticate_user!
      end

      add_desc "执行施工流程"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '流程id'
        requires :order_id, type: Integer, desc: '订单id'
      end
      put 'store_workstations/:id/perform' do
        present notice: {msg: 'perform'}
      end

      add_desc "切换工位"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '流程id'
        requires :order_id, type: Integer, desc: '订单id'
      end
      put 'store_workstations/:id/exchange' do
        present notice: {msg: 'exchange'}
      end

    end
  end
end
