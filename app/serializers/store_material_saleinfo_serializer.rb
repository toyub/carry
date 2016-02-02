class StoreMaterialSaleinfoSerializer < ActiveModel::Serializer
  attributes :id, :name, :speci, :retail_price, :vip_price, :category_name,
    :reward_points, :inventory_quantity, :service_needed, :service_fee_price, :quantity, :recommended_price,
    :bargainable, :bargain_price, :trade_price, :divide_to_retail, :divide_unit_type_id, :divide_total_volume,
    :service_fee_needed, :service_fee,  :vip_price_enabled, :divide_volume_per_bill

  def speci
    object.store_material.speci
  end

  def category_name
    object.sale_category.try(:name)
  end

  def service_fee_price
    if object.service_fee
      object.service_fee
    else
      0
    end
  end

  def inventory_quantity
    0
  end

  def quantity
    1
  end

  def recommended_price
    0
  end
end
