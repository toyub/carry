module V1
  class Mechanics < Grape::API
    before do
      authenticate_platform!
      authenticate_user!
    end

    resource :mechanic do
      resource :workflow_snapshots do
        add_desc '技师状态'
        params do
          requires :platform, type: String, desc: '调用的平台!'
        end
        get  do
          if current_user.store_group_member.blank?
            {status: false, message: '未绑定小组,无法查看状态!'}
          else
            if current_user.store_group_member.busy?
              present current_user, with: ::Entities::Mechanic
            else
              {status: false, message: '暂时没有服务流程，请注意查收!'}
            end
          end

        end
      end

      add_desc '技师上岗'
      params do
        requires :platform, type: String, desc: '调用的平台!'
        requires :id, type: Integer, desc: 'task的id！'
      end
      put do
        if task = current_user.store_staff_tasks.where(id: params[:id]).last
          task.busy!
          {status: 1}
        else
          {status: 0}
        end
      end
    end

  end
end
