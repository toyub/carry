class StoreMaterialInventory < ActiveRecord::Base
  include BaseModel
  belongs_to :store_depot
  belongs_to :store_material
  belongs_to :store_material_order
  belongs_to :store_material_order_item
  has_many :store_material_inventory_records

  def returning!(quantity)
    down!(quantity)
  end

  def outing!(quantity)
    down!(quantity)
  end

  private
  def down!(quantity)
    self.class.unscoped.where(id: self.id).update_all("quantity=COALESCE(quantity, 0) - #{quantity.to_i.abs}")
  end

  def up!
    self.class.unscoped.where(id: self.id).update_all("quantity=COALESCE(quantity, 0) + #{quantity.to_i.abs}")
  end
end
