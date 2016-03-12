module V1
  class ResetPassword < Grape::API

    resource :reset_password do
      before do
        authenticate_platform!
      end

      add_desc '重置密码'

      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :phone_number, type: String, desc: '手机号'
        requires :token, type: String, desc: 'token'
        requires :new_password, type: String, desc: '新密码'
        requires :new_password_confirmation, type: String, desc: '新密码确认'
      end

      post do
        cap = Captcha.by_phone(params[:phone_number]).unexpried.last
        return {success: false, notice: '输入验证码或手机号有误'} unless cap && cap.token_available && cap.authenticate(params[:token])
        staff = StoreStaff.by_phone(params[:phone_number]).unterminated.last
        return {success: false, notice: '用户不存在或密码不匹配'} if staff.blank? || (params[:new_password] != params[:new_password_confirmation])
        staff.reset_password!(params[:new_password], params[:new_password_confirmation])
        cap.disabled_token!
        {success: true, notice: '重置成功'}
      end
    end

  end
end
