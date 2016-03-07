module Api
  module Pos
    module Auth
      class DiscountAuthoritiesController < Api::BaseController
        def create
          staff = current_store.store_staff.where(login_name: params[:login_name]).first

          auth_serv = AuthenticateStaffService.call(staff, params[:password])
          if auth_serv.success?
            if staff.roles.include?(0) || staff.roles.include?(1)
              render json: {valid: true}
            else
              render json: {valid: false, message: '用户验证失败'}, status: 422  
            end
          else
            render json: {valid: false, message: '用户验证失败'}, status: 422
          end
        end
      end
    end
  end
end