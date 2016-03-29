module Xianchang
  class StoreWorkstationsController < BaseController
    before_action :set_workstation, only: [:edit, :update, :finish, :perform]
    before_action :set_groups, only: [:new, :edit]

    def index
      @queuing_orders = current_store.store_orders.task_queuing.available

      @processing_orders_count = current_store.store_orders.processing.available.count
      @paying_orders_count = current_store.store_orders.paying.available.count
      @finished_orders_count = current_store.store_orders.finished.available.count
      @orders_count = current_store.store_orders.available.count
      @pending_orders_count = current_store.store_orders.pending.available.count
      @mechanics_count = StoreStaff.mechanics.count

      @task_finished_orders = current_store.store_orders.task_finished.paying.available.today
      
      @workstations = current_store.workstations.order("id asc")
    end

    def new
      @workstation = current_store.workstations.build
    end

    def create
      @workstation = current_store.workstations.create(append_store_attrs workstation_params)
    end

    def edit
    end

    def update
      @workstation.update(append_store_attrs workstation_params)
    end

    def construction
      @status = UpdateWorkflowService.call(construction_params)
      SpotDispatchJob.perform_now(current_store.id)
    end

    def finish
      @workstation.finish!
    end

    def perform
      @store_order = current_store.store_orders.find(params[:order_id])
      workflow = @store_order.workflows.processing.first || @store_order.workflows.pending.first
      @idle_workstation = workflow.try(:store_workstation)
      @workstation.perform!(@store_order, workflow)
      @store_order.reload
    end

    private
    def set_groups
      @groups = current_store.store_groups.where(deleted: false).pluck(:name, :id)
    end

    def workstation_params
      params.require(:store_workstation).permit(:color, :name, :store_group_id, :status)
    end

    def set_workstation
      @workstation = current_store.workstations.find(params[:id])
    end

    def construction_params
      params.permit(workflow: [:store_workstation_id, :inspector, :used_time, mechanics: [:id, :name]])
    end

  end
end
