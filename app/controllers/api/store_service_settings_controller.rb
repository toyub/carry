module Api
  class StoreServiceSettingsController < BaseController
    before_action :set_service

    def create
      @setting = @service.create_setting(append_store_attrs setting_params)
      respond_with @setting, location: nil
    end

    def update
      @setting = @service.setting
      @setting.workflows.clear
      @setting.update(append_store_attrs setting_params)
      respond_with @setting, location: nil
    end

    def show
      @setting = @service.setting
      respond_with @setting, location: nil
    end

    private

      def set_service
        @service = current_store.store_services.find(params[:store_service_id])
      end

      def setting_params
        params.require(:store_service_setting).permit(
          :setting_type,
          workflows_attributes: [
            :name,
            :engineer_count_enable,
            :engineer_count,
            :engineer_level_enable,
            :engineer_level,
            :standard_time,
            :standard_time_enable,
            :buffering_time_enable,
            :buffering_time,
            :factor_time,
            :nominated_workstation,
            :mechanic_commission_template_id,
            :store_workstation_ids]
        )
      end
  end
end
