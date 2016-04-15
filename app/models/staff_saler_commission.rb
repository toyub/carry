class StaffSalerCommission < StaffBaseCommission

  def initialize(staff, month)
    super
  end

  def order_quantity
    @staff.store_orders.by_month(@month).count
  end

  def sale_quantity
    @order_items.count
  end

  def sale_amount
    @order_items.materials.map(&:amount).sum
  end

  def task_quantity
    0
  end

  def task_amount
    0
  end

  def trade_amount
    @order_items.map(&:amount).sum
  end

  def commission_amount
    @staff.commission? ? @order_items.map(&:commission).sum : 0.0
  end

end
