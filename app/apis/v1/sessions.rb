module V1
  class Sessions < Grape::API

    resource :sessions do
      before do
        authenticate_platform!
        authenticate_sn_code!
      end

      add_desc '登录验证'
      params do
        requires :platform, type: String, desc: "调用平台(app&erp)"
        optional :login_name, type: String, desc: "登录名"
        optional :password, type: String, desc: "密码"
      end

      post do
        staff = StoreStaff.where(login_name: params[:login_name]).unterminated.last
        status = AuthenticateStaffService.call(staff, params[:password],platform: params[:platform])
        if status.success?
          api_token = staff.api_tokens.find_or_create_by(sn_code: request.headers["X-Sn-Code"])
          api_token.reset_token
          present api_token, with: ::Entities::Session
        else
          error! status: status.notice, staff: nil
        end
      end

      add_desc '退出登陆'
      params do
        requires :platform, type: String, desc: "调用平台!"
      end
      delete do
        authenticate_user!
        api_token = ApiToken.where(token: authorization).last
        
        present authorization
      end
    end
  end
end
