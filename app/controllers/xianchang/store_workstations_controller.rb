module Xianchang
  class StoreWorkstationsController < BaseController
    before_action :set_workstation, except: [:index, :new, :create]
    before_action :set_groups, only: [:new, :edit]
    before_action :set_store_order, only: [:start, :exchange, :perform]

    def index
      counts
      @task_finished_orders = current_store.store_orders.available.paying.task_finished_on(Time.now)
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
      @workflow = StoreServiceWorkflowSnapshot.find_by(id: params[:workflow_id]) #要结束的流程，一定是页面上显示的流程
      if @workflow.present?
        if @workflow.id == @workstation.workflow_id #此处因为后台可能已经结束过了，而且分配了下一个任务。所以要判断一下
          @workflow.complete!
        else
          puts "\n"*25, '有问题', @workflow.id, @workstation.workflow_id, "\n"*10
        end
      else
        puts "\n"*25, '找不到了', @workflow, @workstation.workflow_id, "\n"*10
      end
    end

    def perform
      workflow = @store_order.workflows.find_by(id: params[:workflow_id])
      if workflow.present?
        @previous_workstation = workflow.store_workstation
        @workstation.perform!(@store_order, workflow)
      end
      @store_order.reload
    end

    def exchange
      @workflow = @store_order.workflows.find_by(id: params[:workflow_id])
      @previous_workstation = @workflow.store_workstation
      @workflow.change_workstation_to!(@workstation)
    end

    def start
      service = @store_order.store_service_snapshots.not_deleted.pending.order_by_itemd.first
      if service.present?
        @workflow = service.workflow_snapshots.not_deleted.pending.order_by_flow.first
        if @workflow.present?
          @workstation.start!(@workflow)
        end
      end
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
