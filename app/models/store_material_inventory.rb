class StoreMaterialInventory < ActiveRecord::Base
  belongs_to :store_depot
  belongs_to :store_material
  belongs_to :store_material_order
  belongs_to :store_material_order_item
  has_many :store_material_inventory_records

  def returning!(quantity)
    quantity = quantity.to_i.abs
    self.class.unscoped.where(id: self.id).update_all("quantity=COALESCE(quantity, 0) - #{quantity.to_i}")
  end

  def outing!(quantity)
    quantity = quantity.to_i.abs
    self.class.unscoped.where(id: self.id).update_all("quantity=COALESCE(quantity, 0) - #{quantity.to_i}")
  end
end
