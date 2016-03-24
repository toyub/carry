class StoreMaterialIncome < StoreMaterialLog

  def self.count_by_material(material, month = nil, depot_id = nil)
    month = Time.now.strftime("%Y%m") if month == nil
    incomes = by_material_id(material.id).by_depot_id(depot_id).by_month(month)
    incomes.by_depot_id(depot_id) if depot_id.present?
    count = incomes.map do |income|
      income.accruals['quantity'].to_i
    end.sum
    {quantity: count, amount: (count * material.cost_price.to_f)}
  end

end
