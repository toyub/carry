class StoreMaterialIncome < StoreMaterialLog

  def openings_amount
    openings['inventory_cost_price'].to_f * openings['inventory_quantity'].to_i
  end

end
