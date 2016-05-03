class HomeCountersPresenter
  def initialize(store, time=Time.now)
    @current_store = store
    @current_time = time
  end

  def attendances_mechanics_count
    @attendances_mechanics_count ||= @current_store.store_group_members.available.attendances.count(:id)
  end

  def available_workstations_count
    @available_workstations_count ||= @current_store.workstations.available.count(:id)
  end

  def complaints_count
    @complaints_count ||= @current_store.complaints.by_day(@current_time).count(:id)
  end

  def sale_revenue
    @sale_revenue ||= @current_store.store_orders.available.paid.paid_on(@current_time).sum(:amount)
  end

  def pay_hangings_amount
    @pay_hangings_amount ||= @current_store.store_orders.available.by_day(@current_time).pay_hanging.sum(:amount)
  end

  def customer_assets_revenue
    @customer_assets_revenue ||= @current_store.store_order_items
                    .available
                    .from_asset
                    .where(store_orders: { pay_status: [ StoreOrder.pay_statuses[:pay_hanging], StoreOrder.pay_statuses[:pay_finished] ]})
                    .by_day(@current_time)
                    .map(&:vip_amount).sum
  end

  def payings_count
    @pay_hangings_count ||= @current_store.store_orders.available.created_before(@current_time).paying.count(:id)
  end


  def task_pausings_count
    @task_pausings_count ||= @current_store.store_orders.available.created_before(@current_time).task_pausing.count(:id)
  end

  def orders_count
    @orders_count ||= @current_store.store_orders.available.by_day(@current_time).count(:id)
  end

  def processing_orders_count
    @processing_orders_count ||= @current_store.store_orders.available.created_before(@current_time).processing.count(:id)
  end

  def finished_orders_count
    @finished_orders_count ||= @current_store.store_orders.available.finished.task_finished_on(@current_time).count(:id)
  end

  def task_queuings_count
    @task_queuings_count ||= @current_store.store_orders.available.created_before(@current_time).task_queuing.count(:id)
  end
end
