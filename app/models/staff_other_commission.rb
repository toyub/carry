class StaffOtherCommission < StaffBaseCommission

  def initialize(staff, month)
    @staff = staff
    @month = month
  end

  def order_quantity
    0
  end

  def sale_quantity
    0
  end

  def sale_amount
    0.0
  end

  def task_quantity
    0.0
  end

  def task_amount
    0
  end

  def trade_amount
    0.0
  end

  def commission_amount
    0.0
  end

end
