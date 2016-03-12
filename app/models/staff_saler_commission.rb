class StaffMechanicCommission
  include StaffBaseCommission

  def initialize(staff, month)
    @staff = staff
    @month = month
  end

  def order_quantity
    @staff.store_orders.by_month(@month).count
  end

  def sale_quantity
    @staff.store_order_items.except_from_customer_assets.by_month(@month).count
  end

  def sale_amount
    @staff.materials_amount_total(@month)
  end

  def task_quantity
    0
  end

  def task_amount
    0
  end

  def trade_amount
    @staff.store_order_items.by_month(@month).map(&:amount).sum
  end

  def commission_amount
    @staff.store_order_items.by_month(@month).map(&:commission).sum
  end

end
