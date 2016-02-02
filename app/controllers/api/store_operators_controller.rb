module Api
  class StoreOperatorsController < BaseController
    def index
      @staffers = current_store.store_staff.where({mis_login_enabled: true})
      respond_with @staffers, location: nil
    end

    def update
      @staffer = current_store.store_staff.find(params[:id])
      @staffer.update(staff_params)
      respond_with @staffer, location: nil
    end

    private
      def staff_params
        params.require(:store_staff).permit(roles: [])
      end
  end
end
