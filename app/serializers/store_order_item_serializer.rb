class StoreOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :retail_price, :price, :quantity, :amount, :vip_price, :speci,
    :discount, :discount_reason

  def name
    object.orderable.name
  end

  def retail_price
    object.orderable.retail_price
  end

  # TODO set correct vip_price
  def vip_price
    0
  end

  def speci
    if object.orderable_type == "StoreMaterialSaleinfo"
      object.orderable.store_material.speci
    else
      ""
    end
  end
end
