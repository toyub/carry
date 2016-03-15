module StaffBaseCommission
  def commission
    {
      order_quantity:            order_quantity,
      sale_quantity:             sale_quantity,
      sale_amount:               sale_amount,
      task_quantity:             task_quantity,
      task_amount:               task_amount,
      trade_amount:              trade_amount,
      commission_amount:         commission_amount
    }
  end
end
