module Api
  module Pos
    module Auth
      class WasteOrderAuthoritiesController < Api::BaseController
        def create
          staff = current_store.store_staff.where(login_name: params[:login_name]).first

          auth_serv = AuthenticateStaffService.call(staff, params[:password])
          if auth_serv.success? && staff.has_waste_order_authority?
            render json: {valid: true, message: '用户验证成功', staff:{id: staff.id}}
          else
            render json: {valid: false, message: '用户验证失败'}, status: 422
          end
        end
      end
    end
  end
end