#store material transfer receipt items
class StoreMaterialTransReceiptItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_picking
  belongs_to :store_material_picking_item
  belongs_to :sotre_material_inventory
  belongs_to :store_material_receipt
  belongs_to :store_material

  def amount
    self.quantity * self.ordered_cost_price
  end
end
