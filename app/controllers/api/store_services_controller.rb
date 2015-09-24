module Api
  class StoreServicesController < BaseController
    before_action :set_service, except: [:create, :index]

    def create
      @service = current_store.store_services.create(service_params.merge(store_staff_id: current_staff.id))
      respond_with @service, location: nil
    end

    def show
      respond_with @service, location: nil
    end

    def update
      @service.store_materials.clear
      @service.update(service_params)
      respond_with @service, location: nil
    end

    def save_picture
      @service.uploads.create(img_params)
      respond_with @service, location: nil
    end

    def index
      @q = current_store.store_services.ransack(params[:q])
      @services = @q.result(distinct: true)
      respond_with @services
    end

    private

      def set_service
        @service = current_store.store_services.find(params[:id])
      end

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
          store_service_store_materials_attributes: [:store_material_id]
        )
      end

      def img_params
        params.permit(:img).merge(store_staff_id: current_staff.id, store_id: current_store.id)
      end
  end
end
