module V1
  class DiscountAuthorities < Grape::API
    resource :discount_authorities do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '折扣权限验证'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :login_name, type: String, desc: '要进行权限验证的员工的登录名'
        requires :password, type: String, desc: '密码'
      end

      post do
        staff = current_store.store_staff.where(login_name: params[:login_name]).unterminated.last
        auth_result = AuthenticateStaffService.call(staff, params[:password])
        result = if auth_result.success? && staff.has_discount_authority?
           {valid: true, msg: '用户验证成功'}
        else
           {valid: false, msg: '用户验证失败'}
        end
        present result
      end
    end
  end
end
