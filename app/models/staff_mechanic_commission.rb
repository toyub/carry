class StaffMechanicCommission
  include StaffBaseCommission

  def initialize(staff, month)
    @staff = staff
    @month = month
  end

  def order_quantity
    (@staff.store_orders.by_month(@month).pluck(:id) + @staff.store_staff_tasks.joins(:store_order_item => :store_order).pluck("store_orders.id").uniq).uniq.count
  end

  def sale_quantity
    @staff.store_order_items.except_from_customer_assets.by_month(@month).count
  end

  def sale_amount
    @staff.materials_amount_total(@month)
  end

  def task_quantity
    @staff.store_staff_tasks.by_month(@month).select(:store_order_item_id).uniq.count
  end

  def task_amount
    0
  end

  def trade_amount
    @staff.store_order_items.by_month(@month).map(&:amount).sum
  end

  def commission_amount
    @staff.commission? ? @staff.store_order_items.by_month(@month).map(&:commission).sum + @staff.store_staff_tasks.by_month(@month).map(&:commission).sum : 0.0
  end

end
