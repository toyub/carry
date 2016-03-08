class StoreMaterialInventoryRecord < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material_order
  belongs_to :store_material_order_item
  belongs_to :store_material_inventory
  belongs_to :store_staff

  def price
    self.ordered_cost_price
  end

  def amount
    self.quantity * self.price
  end
end
