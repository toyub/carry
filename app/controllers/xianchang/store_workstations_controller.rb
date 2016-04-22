module Xianchang
  class StoreWorkstationsController < BaseController
    before_action :set_workstation, except: [:index, :new, :create]
    before_action :set_groups, only: [:new, :edit]
    before_action :set_store_order, only: [:start, :exchange, :perform]

    def index
      counts
      @task_finished_orders = current_store.store_orders.available.task_finished.paying.task_finished_on(Time.now)
      @pausing_orders = current_store.store_orders.available.pausing.waiting_in_queue
      @queuing_orders = current_store.store_orders.available.queuing.waiting_in_queue
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

    def finish
      @workstation.finish!
    end

    def perform
      workflow = @store_order.workflows.processing.first || @store_order.workflows.pending.first
      @previous_workstation = workflow.try(:store_workstation)
      @workstation.perform!(@store_order, workflow)
      @store_order.reload
    end

    def exchange
      @workflow = @store_order.workflows.processing.first || @store_order.workflows.pending.first
      @previous_workstation = current_store.workstations.find(params[:previous_workstation])
      @workflow.exchange!(@previous_workstation, @workstation)
    end

    def start
      @workflow = @store_order.workflows.processing.first || @store_order.workflows.pending.first
      @workstation.start!(@workflow)
    end

    private
    def set_groups
      @groups = current_store.store_groups.where(deleted: false).pluck(:name, :id)
    end

    def set_store_order
      @store_order = current_store.store_orders.find(params[:order_id])
    end

    def workstation_params
      params.require(:store_workstation).permit(:color, :name, :store_group_id, :status)
    end

    def set_workstation
      @workstation = current_store.workstations.find(params[:id])
    end
  end
end
