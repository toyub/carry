class StoreMaterialOutingItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :requester, class_name: 'StoreStaff'
  belongs_to :store_material_inventory
  belongs_to :store_material

  def outing_type
    OutingType.find(self.outing_type_id)
  end
end
