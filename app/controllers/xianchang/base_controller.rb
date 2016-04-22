module Xianchang
  class BaseController < ApplicationController
    before_action :login_required

    def counts
      available_orders_scope = current_store.store_orders.available

      queuing_count = available_orders_scope.queuing.count(:id)
      processing_count = available_orders_scope.processing.count(:id)
      pausing_count = available_orders_scope.pausing.count(:id)
      task_finished_count = available_orders_scope.task_finished.task_finished_on(Date.today).count
      finished_count = available_orders_scope.finished.paid_on(Date.today).count


      total_count = queuing_count + processing_count + pausing_count + task_finished_count + finished_count
      @order_counts= {
        queuing: queuing_count,
        processing: processing_count,
        pausing: pausing_count,
        task_finished: task_finished_count,
        finished: finished_count,
        total: total_count
      }

      @mechanics_count = current_store.store_staff.mechanics.count(:id)
      @worker_counts = current_store.store_group_members.available.count_by_work_statuses
      @workstations = current_store.workstations.order("id asc")
    end
  end
end
