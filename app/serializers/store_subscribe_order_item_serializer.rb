class StoreSubscribeOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :name, :quantity

  def price
    case object.itemable_type
    when "StoreMaterial"
      object.itemable.cost_price
    when "StoreService"
      object.itemable.retail_price
    when "StorePackage"
      object.itemable.price
    end
  end

  def name
    object.itemable.name
  end
end
