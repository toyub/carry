module Api
  module Order
    class LoginController < BaseController
      before_action :get_staff, only: [:login]
      def login
        @status = AuthenticateStaffService.call(@staff, params[:user_password])
       if @status.success?
         session[:user_id] = @staff.id
         respond_with @staff,@status, location: nil
       else
         render json: { staff: nil, info: @status.notice }
       end
      end

      private
      def get_staff
        @store_staff = StoreStaff.find_by(login_name: params[:user_name])
        @staff = StoreStaffLoginSerializer.new(@store_staff) if @store_staff
      end
    end
  end
end
