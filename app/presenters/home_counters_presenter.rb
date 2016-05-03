class HomeCountersPresenter
  def initialize(store, time=Time.now)
    @current_store = store
    @current_time = time
  end

  def mechanics
    @current_store.store_group_members.available
  end

  def today_complaints
    @current_store.complaints.by_day(@current_time)
  end

  def yesterday_complaints
    @current_store.complaints.by_day(@current_time.yesterday)
  end

  def yesterday_order_items
    @current_store.store_order_items.by_day(@current_time.yesterday)
  end

  def today_order_items
    @current_store.store_order_items.by_day(@current_time)
  end

  def paid_on_today
    @current_store.store_orders.paid_on(@current_time)
  end

  def paid_on_yesterday
    @current_store.store_orders.paid_on(@current_time.yesterday)
  end

  def today_orders
    @current_store.store_orders.today
  end

  def yesterday_orders
    @current_store.store_orders.by_day(@current_time.yesterday)
  end
end
