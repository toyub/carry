module Api
  class StoreServicesController < BaseController
    def create
      @service = current_store.store_services.create(service_params.merge(store_staff_id: current_staff.id))
      respond_with @service, location: nil
    end

    private

      def service_params
        params.require(:store_service).permit(
          :name, :code, :retail_price,
          :bargain_price, :point,
          :introduction, :remark,
          :store_service_category_id, :favorable,
          store_service_store_materials_attributes: [:store_material_id, :use_mode]
        )
      end
  end
end
