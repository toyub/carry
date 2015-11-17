class StoreMaterialCheckinItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_checkin
  belongs_to :store_material
  belongs_to :store_material_inventory

  def cost_price
    self.price
  end
end
