module Xianchang
  class BaseController < ApplicationController
    before_action :login_required

    def counts
      @order_counts = current_store.store_orders.available.counts_by_state
      @mechanics_count = current_store.store_staff.mechanics.count(:id)
      @worker_counts = current_store.store_group_members.available.count_by_work_statuses     
      @workstations = current_store.workstations.order("id asc")
    end
  end
end
