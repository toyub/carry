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
        requires :captcha, type: String, desc: '验证码'
        requires :new_password, type: String, desc: '新密码'
        requires :new_password_confirmation, type: String, desc: '新密码确认'
      end

      post do
        return {status: 'failed', notice: '输入验证码有误'} unless Captcha.authenticate(params[:phone_number], params[:captcha])
        staff = StoreStaff.by_phone(params[:phone_number]).unterminated.last
        return {status: 'failed', notice: '用户不存在或密码不匹配'} if staff.blank? || (params[:new_password] != params[:new_password_confirmation])
        Captcha.valid_captchas(params[:phone_number]).last.try(:disabled_token!)
        staff.reset_password!(params[:new_password], params[:new_password_confirmation])
        {status: 'success', notice: '重置成功'}
      end
    end

  end
end
