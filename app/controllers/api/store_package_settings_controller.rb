module Api
  class StorePackageSettingsController < BaseController
    before_action :set_package
    before_action :set_setting, except: [:create]

    def create
      @setting = @package.create_package_setting(append_store_attrs setting_params)
      respond_with @setting, location: nil
    end

    def update
      @setting.items.where.not(id: (setting_params[:items_attributes] || []).map {|x| x[:id]}).update_all(deleted: true)
      @setting.update(append_store_attrs setting_params)
      respond_with @setting, location: nil
    end

    def show
    end

    private

      def set_package
        @package = current_store.store_packages.find(params[:store_package_id])
      end

      def set_setting
        @setting = @package.package_setting
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
            :id,
            :name,
            :quantity,
            :price,
            :denomination,
            :package_itemable_id,
            :package_itemable_type,
            :amount
          ]
        )
      end
  end
end
