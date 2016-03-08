module Xianchang
  class StoreWorkflowsController < BaseController
    before_action :set_workflow

    def edit
    end

    def update
      @workflow.used_time = @workflow.used_time.to_i + workflow_params[:overtime_interval].to_i
      @workflow.overtimes = @workflow.overtimes << workflow_params
      @workflow.save
    end

    def free_mechanics
      @mechanics = @workflow.ready_mechanics(params[:workstation]) || []
    end

    private

    def set_workflow
      @workflow = current_store.workflows.find(params[:id])
    end

    def workflow_params
      params.require(:store_service_workflow_snapshot).permit(:overtime_interval, :overtime_reason)
    end

  end
end
