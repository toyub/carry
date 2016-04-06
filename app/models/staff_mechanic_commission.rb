class StaffMechanicCommission < StaffBaseCommission

  def initialize(staff, month)
    super
  end

  def order_quantity
    (@staff.store_orders.by_month(@month).pluck(:id) + @staff.store_staff_tasks.joins(:store_order_item => :store_order).pluck("store_orders.id").uniq).uniq.count
  end

  def sale_quantity
    @order_items.count
  end

  def sale_amount
    @order_items.materials.map(&:amount).sum
  end

  def task_quantity
    @tasks.select(:store_order_item_id).uniq.count
  end

  def task_amount
    0
  end

  def trade_amount
    @order_items.map(&:amount).sum
  end

  def commission_amount
    @staff.commission? ? @order_items.map(&:commission).sum + @tasks.map(&:commission).sum : 0.0
  end

end
