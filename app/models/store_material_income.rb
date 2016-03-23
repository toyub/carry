class StoreMaterialIncome < StoreMaterialLog

  def self.count_by_material(material)
    where(store_material_id: material.id).map do |income|
      income.accruals['quantity'].to_i
    end.sum
  end

  def self.price_by_material(material)
    #FIXME
    material.cost_price.to_f
  end

  def self.amount_by_material(material)
    price_by_material(material) * count_by_material(material)
  end


end
