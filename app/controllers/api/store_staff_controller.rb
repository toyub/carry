module Api
  class StoreStaffController < BaseController
    def index
      @staffers = current_store.store_staff.all
      respond_with @staffers, location: nil
    end

    def update
      @staffer = current_store.store_staff.find(params[:id])
      @staffer.update(staff_params)
      respond_with @staffer, location: nil
    end

    def check_phone
      staff = StoreStaff.find_by(phone_number: params[:phone_number])
      if staff.present?
        render json: {success: false, notice: "#{params[:phone_number]}已被使用，请重新输入"}
      else
        render json: {success: true, notice: "#{params[:phone_number]}可用"}
      end
    end

    private
      def staff_params
        params.require(:store_staff).permit(roles: [])
      end
  end
end
