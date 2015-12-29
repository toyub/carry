class StoreMaterialOutingItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :requester, class_name: 'StoreStaff'
  belongs_to :store_material_inventory
  belongs_to :store_material

  before_save :calc_amount

  def outing_type
    OutingType.find(self.outing_type_id)
  end

  def calc_amount
    self.amount = self.quantity * self.cost_price
  end
end
