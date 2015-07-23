module Xiaoshou
  module Service
    class SettingsController < Xiaoshou::BaseController

      def new
      end

      private

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
