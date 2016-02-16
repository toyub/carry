module Xianchang
  class StoreWorkstationsController < BaseController
    before_action :set_workstation, only: [:edit, :update, :finish, :perform]
    before_action :set_groups, only: [:new, :edit]

    def index
      @queuing_orders = current_store.store_orders.queuing

      @processing_orders_count = current_store.store_orders.processing.count
      @paying_orders_count = current_store.store_orders.paying.count
      @finished_orders_count = current_store.store_orders.finished.count
      @orders_count = current_store.store_orders.count
      @pending_orders_count = current_store.store_orders.pending.count
      @mechanics_count = StoreStaff.mechanics.count

      @task_finished_orders = current_store.store_orders.task_finished
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
    end

    def finish
      @workstation.finish!
    end

    def perform
      @store_order = current_store.store_orders.find(params[:order_id])
      @idle_workstation = @store_order.workflows.processing.first.try(:store_workstation)
      @workstation.perform!(@store_order)
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
      params.permit(workflow: [:store_workstation_id, :used_time, mechanics: [:id, :name]])
    end

  end
end
