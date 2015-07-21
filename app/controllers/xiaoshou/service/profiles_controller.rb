module Xiaoshou
  module Service
    class ProfilesController < Xiaoshou::BaseController
      respond_to :json, only: [:create]
      def index
        @services = current_store.store_services
      end

      def new
        load_data
        @service = current_store.store_services.new
      end

      def create
        @service = current_store.store_services.create(profile_params.merge(store_staff_id: current_staff.id).merge(store_service_store_materials_attrs))
        respond_with @service
      end

      private

      def load_data
        @services = current_store.store_services
        @categories = current_store.service_categories.order("created_at desc")
        @material_categories = current_store.store_material_categories.super_categories.order("created_at desc")
        @sub_categories = @material_categories.first.sub_categories.map {|c| [c.name, c.id]} if @material_categories.present?
        category = @sub_categories.present? ? @sub_categories.first[1] : @material_categories.first.id
        @materials = current_store.store_materials.where(store_material_category_id: category)
      end

      def profile_params
        params.require(:store_service).permit(
          :name, :code, :retail_price,
          :bargain_price, :point,
          :introduction, :remark,
          :store_service_category_id, :favorable,
          store_service_store_materials_attributes: [:store_material_id, :use_mode]
        )
      end

      def store_service_store_materials_attrs
        return {} unless profile_params[:store_service_store_materials_attributes].present?
        {
          store_service_store_materials_attributes: profile_params[:store_service_store_materials_attributes].transform_values do |x|
            x.merge(store_id: current_store.id, store_staff_id: current_staff.id)
          end
        }
      end
    end
  end
end
