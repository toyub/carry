class StoreMaterialOutgo < StoreMaterialLog

  def closings_amount
    closings['inventory_cost_price'].to_f * closings['inventory_quantity'].to_i || 0.0
  end

end
