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
          task = current_user.store_staff_tasks.current_task

          if task.present?
            result = {status: true, message: '存在流程!', task: task}
          else
            result = {status: false, message: '暂时不存在流程，请注意查收!', task: nil}
          end
          present result, with: ::Entities::TaskResult
        end
      end

      add_desc '技师上岗'
      params do
        requires :platform, type: String, desc: '调用的平台!'
        requires :id, type: Integer, desc: 'task的id！'
      end
      put do
        if task = current_user.store_staff_tasks.ready.where(id: params[:id]).last
          task.busy!
          if current_user.store_group_member
            current_user.store_group_member.busy!
            {status: true, message: '上岗成功！'}
          else
            {status: false, message: '由于系统原因请重试！'}
          end
        else
          {status: false, message: '当前不存在需要上岗任务!'}
        end
      end
    end

  end
end
