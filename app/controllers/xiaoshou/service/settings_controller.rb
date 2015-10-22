module Xiaoshou
  module Service
    class SettingsController < Xiaoshou::BaseController
      respond_to :html, :json

      before_action :set_service, only: [:edit, :update, :show]
      before_action :check_path, only: :edit

      def edit
        @service.store_service_workflows.build if @service.store_service_workflows.blank?
        @workflows = @service.store_service_workflows
        @workstation_categories = current_store.store_workstation_categories
        @workstations = StoreWorkstation.all
        @commission_templates = current_store.store_commission_templates.map {|t| [t.name, t.id]}
      end

      def update
        @workflow = @service.store_service_workflows.create(setting_params.merge(store_id: current_store.id))
        respond_with @workflow
      end

      def show
        @workflow = StoreServiceWorkflowSerializer.new(@service.store_service_workflows.first) if @service.regular?
      end

      private

      def set_service
        @service = current_store.store_services.find(params[:id])
      end

      def check_path
        redirect_to xiaoshou_service_setting_path(@service) and return if @service.store_service_workflows.count > 0
      end

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
