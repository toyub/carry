module Xiaoshou
  module Service
    class SettingsController < Xiaoshou::BaseController
      respond_to :html, :json

      def edit
        @service = current_store.store_services.find(params[:id])
        @workflow = @service.store_service_workflows.new
        @workstation_categories = current_store.store_workstation_categories
        @commission_templates = current_store.store_commission_templates.map {|t| [t.name, t.id]}
      end

      def update
        binding.pry
        @service = current_store.store_services.find(params[:id])
        @workflow = @service.store_service_workflows.create(setting_params.merge(store_id: current_store.id))
        respond_with @workflow
      end

      def index
        
      end

      private

      def setting_params
        params.require(:store_service_workflow).permit(
          :engineer_level, :engineer_count, :position_mode, :standard_time, :buffering_time,
          :factor_time, :sales_commission_subject, :sales_commission_template_id,
          :engineer_commission_subject, :engineer_commission_template_id,
          :engineer_count_enable, :engineer_level_enable,
          :standard_time_enable, :buffering_time_enable,
          :store_workstation_ids, :nominated_workstation
        )
      end
    end
  end
end
