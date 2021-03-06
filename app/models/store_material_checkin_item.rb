class StoreMaterialCheckinItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_checkin
  belongs_to :store_material
  belongs_to :store_material_inventory
  belongs_to :store_depot
  belongs_to :store_staff

  def cost_price
    self.price
  end

  def numero
    store_material_checkin.numero
  end

  def format_created_at
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
