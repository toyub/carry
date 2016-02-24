module V1
  class ResetPassword < Grape::API

    resource :reset_password do
      before do
        authenticate_platform!
        authenticate_sn_code!
      end

      add_desc '重置密码'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :phone_number, type: String, desc: '手机号'
        requires :new_password, type: String, desc: '新密码'
        requires :pass_confirmation, type: String, desc: '新密码确认'
      end

      post do
        staff = StoreStaff.find_by(phone_number: params[:phone_number])
        return {status: 'failed', notice: 'user is not exist or password do unmatch'} if staff.blank? || (params[:new_password] != params[:pass_confirmation])
        staff.reset_password!(params[:new_password], params[:pass_confirmation])
        {status: 'success', notice: 'reset password successfully'}
      end
    end

  end
end
