module Xianchang
  class GroupsController < BaseController
    def index
      @order_counts = current_store.store_orders.available.counts_by_state
      @mechanics_count = current_store.store_staff.mechanics.count(:id)
      @worker_counts = current_store.store_group_members.count_by_work_statuses
    end
  end
end
