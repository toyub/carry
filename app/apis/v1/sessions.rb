module V1
  class Sessions < Grape::API

    resource :sessions do
      before do
        authenticate_sn_code!
      end

      add_desc '登录验证'
      params do
        optional :login_name, type: String, desc: "登录名"
        optional :password, type: String, desc: "密码"
      end

      post do
        staff = StoreStaff.find_by(login_name: params[:login_name])
        status = AuthenticateStaffService.call(staff, params[:password])
        if status.success?
          api_token = staff.api_tokens.find_or_create_by(sn_code: request.headers["X-Sn-Code"])
          api_token.reset_token
          present authorization: api_token.token
        else
          error! status: status.notice
        end
      end
    end
  end
end
