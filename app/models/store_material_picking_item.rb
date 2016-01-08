class StoreMaterialPickingItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :store_material
  belongs_to :store_material_picking
  belongs_to :store_material_inventory
  belongs_to :store_depot
  belongs_to :dest_depot, class_name: 'StoreDepot'

  def outing_type
    OutingType.find_by_name('转移出库')
  end
end
