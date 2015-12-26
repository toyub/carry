module Xianchang
  class WorkstationsController < BaseController
    def index
      @queuing_orders = current_store.store_orders.queuing
      @processing_orders = current_store.store_orders.processing
      @paying_orders = current_store.store_orders.paying
      @finished_orders = current_store.store_orders.finished

      @workstations = current_store.workstations
    end

  end
end
