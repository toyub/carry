class StoreMaterialOutgo < StoreMaterialLog

  def closings_amount
    closings['inventory_cost_price'] * closings['inventory_quantity']
  end

  def accruals_amount
    accruals['cost_price'] * accruals['quantity']
  end

end
