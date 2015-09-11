module Api
  class StoreServicesController < BaseController
    def create
      @service = current_store.store_services.create(service_params.merge(store_staff_id: current_staff.id))
      respond_with @service, location: nil
    end

    def update
      binding.pry
      @service = current_store.store_services.find(params[:id])
      @service.store_service_workflows.clear
      @service.update(service_params)
      respond_with @service, location: nil
    end

    def save_picture
      @service = StoreService.find(params[:id])
      @service.uploads.create(img_params)
      respond_with @service, location: nil
    end

    private

      def service_params_with_attrs
        attrs = service_params
        attrs[:store_service_workflows_attributes] = attrs[:store_service_workflows_attributes].transform_values {|x| x.merge(store_id: current_store.id, store_staff_id: current_staff.id)}
        attrs
      end

      def service_params
        params.require(:store_service).permit(
          :name, :code, :retail_price,
          :bargain_price, :point,
          :introduction, :remark,
          :store_service_category_id, :favorable,
          store_service_store_materials_attributes: [:store_material_id, :use_mode]
        )
      end

      def img_params
        params.permit(:img).merge(store_staff_id: current_staff.id, store_id: current_store.id)
      end
  end
end
