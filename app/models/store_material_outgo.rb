class StoreMaterialOutgo < StoreMaterialLog

  def self.count_by_material(material)
    where(store_material_id: material.id).map do |outgo|
      outgo.accruals['quantity'].to_i
    end.sum
  end

  def self.price_by_material(material)
    material.cost_price.to_f
  end

  def self.amount_by_material(material)
    price_by_material(material) * count_by_material(material)
  end

end
