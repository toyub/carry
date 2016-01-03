class StoreMaterialIncome < StoreMaterialLog

  def openings_amount
    openings['inventory_cost_price'] * openings['inventory_quantity']
  end

  def accruals_amount
    accruals['cost_price'] * accruals['quantity']
  end

end
