module Api
  class StoreServicesController < BaseController
    include Uploadable

    before_action :set_service, except: [:create, :index, :search]

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

    def index
      @q = current_store.store_services.ransack(params[:q])
      @services = @q.result(distinct: true).order("id asc")
    end

    def search
      store_services = current_store.store_services.where("name like ?", "%#{params[:term]}%").page(params[:page])
      render json: store_services
    end

    private
      def resource
        @service ||= set_service
      end

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
          :bargain_price, :point, :category_id,
          :introduction, :remark, :favorable, :bargain_price_enabled,
          :saleman_commission_template_id, :vip_price_enabled,
          store_service_store_materials_attributes: [:store_material_id]
        )
      end
  end
end
