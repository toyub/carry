module Xiaoshou
  module Service
    class SettingsController < Xiaoshou::BaseController
      before_action :load_store

      def new
        @services = @store.store_services
        @service = @store.store_services.new
      end

      private
      def load_store
        @store = current_user.store
      end

      def setting_params
        params.require(:store_service).permit(
          :name, :code, :retail_price,
          :bargain_price, :point,
          :introduction, :remark,
          :store_service_category_id, :favorable
        )
      end
    end
  end
end
