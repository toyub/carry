module Api
  class StorePackageSettingsController < BaseController
    before_action :set_package
    before_action :set_setting, only: [:update]

    def create
      @setting = @package.create_store_package_setting(append_store_attrs setting_params)
      respond_with @setting, location: nil
    end

    def update
      @setting.items.clear
      @setting.update(append_store_attrs setting_params)
      respond_with @setting, location: nil
    end

    private

      def set_package
        @package = current_store.store_packages.find(params[:store_package_id])
      end

      def set_setting
        @setting = @package.store_package_setting
      end

      def setting_params
        params.require(:store_package_setting).permit(
          :apply_range,
          :period,
          :period_enable,
          :period_unit,
          :expired_notice_required,
          :before_expired,
          :point,
          :payment_mode,
          :store_commission_template_id,
          items_attributes: [
            :name,
            :quantity,
            :price,
            :denomination,
            :package_itemable_id,
            :package_itemable_type
          ]
        )
      end
  end
end
