class StoreSubscribeOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :name, :quantity

  def price
    object.itemable.retail_price
  end

  def name
    object.itemable.name
  end
end
