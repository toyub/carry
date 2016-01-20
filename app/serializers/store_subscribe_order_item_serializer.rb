class StoreSubscribeOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :name, :quantity

  def price
    object.itemable.try(:retail_price)
  end

  def name
    object.itemable.try(:name)
  end
end
