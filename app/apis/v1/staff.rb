module V1
  class Staff < Grape::API

    resource :staff, desc: "员工相关" do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc "员工列表"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer, desc: "所属门店ID"
          optional :store_department_id_eq, type: Integer, desc: "所属门店部门ID"
          optional :store_position_id_eq, type: Integer, desc: "所属门店职务ID"
          optional :level_type_id_eq, type: Integer, desc: "提成等级"
          optional :employeed_at_eq, type: Date, desc: "入职时间"
        end
      end

      get do
        q = StoreStaff.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::Staff
      end

    end
  end
end
