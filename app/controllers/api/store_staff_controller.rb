module Api
  class StoreStaffController < BaseController
    def index
      @staffers = StoreStaff.all
      respond_with @staffers, location: nil
    end

    def update
      @staffer = StoreStaff.find(params[:id])
      @staffer.update(staff_params)
      respond_with @staffer, location: nil
    end

    private
      def staff_params
        params.require(:store_staff).permit(roles: [])
      end
  end
end