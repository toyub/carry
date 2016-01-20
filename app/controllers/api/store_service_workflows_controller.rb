module Api
  class StoreServiceWorkflowsController < BaseController
    before_action :set_service
    before_action :set_workflow, except: [:create]

    def create
      workflow = @store_service.store_service_workflows.create(workflow_params)
      respond_with workflow, location: nil
    end

    def destroy
      respond_with @workflow.destroy
    end

    def update
      respond_with @workflow.update(workflow_params)
    end

    private
      def workflow_params
        params.require(:store_service_workflow).permit(
          :name, :engineer_level, :engineer_count, :position_mode,
          :engineer_count_enable,
          :standard_time, :buffering_time, :factor_time,
          :mechanic_commission_template_id, :nominated_workstation,
          store_workstation_ids: []).merge(store_staff_id: current_staff.id, store_id: current_store.id)
      end

      def set_service
        @store_service = current_store.store_services.find(params[:store_service_id])
      end

      def set_workflow
        @workflow = @store_service.store_service_workflows.find(params[:id])
      end
  end
end
