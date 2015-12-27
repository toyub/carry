module Xianchang
  class StoreWorkstationsController < BaseController
    before_action :set_workstation, only: [:edit, :update]

    def index
      @queuing_orders = current_store.store_orders.queuing
      @processing_orders = current_store.store_orders.processing
      @paying_orders = current_store.store_orders.paying
      @finished_orders = current_store.store_orders.finished

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

    private
    def workstation_params
      params.require(:store_workstation).permit(:color, :name, :store_workstation_category_id, :available)
    end

    def set_workstation
      @workstation = current_store.workstations.find(params[:id])
    end

  end
end
