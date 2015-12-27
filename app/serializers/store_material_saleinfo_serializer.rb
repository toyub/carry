class StoreMaterialSaleinfoSerializer < ActiveModel::Serializer
  attributes :name, :id, :speci, :retail_price, :vip_price, :category_name,
    :reward_points, :inventory_quantity, :service_needed, :service_fee_price

  def speci
    object.store_material.speci
  end

  def category_name
    object.store_material_saleinfo_category.try(:name)
  end

  def vip_price
    nil
  end

  def service_fee_price
    if object.service_fee
      object.service_fee
    else
      0
    end
  end

  def inventory_quantity
    store_depot = StoreDepot.where(preferred: true).first
    if store_depot
      object.store_material.inventory(store_depot.id)
    else
      0
    end
  end
end