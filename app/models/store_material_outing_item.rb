class StoreMaterialOutingItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :requester, class_name: 'StoreStaff'
  belongs_to :store_material_inventory
  belongs_to :store_material

  before_save :calc_amount
  belongs_to :outingable_item, polymorphic: true
  belongs_to :store_material_outing
  scope :sold, -> { where(outing_type_id: OutingType.find_by_name("销售出库").id) }

  def outing_type
    OutingType.find(self.outing_type_id)
  end

  def calc_amount
    self.amount = self.quantity * self.cost_price
  end

  def gross_profit_rate
    ((outingable_item.amount - outingable_item.cost_price.to_f * outingable_item.quantity)/outingable_item.amount).round(2)
  end

  def numero
    store_material_outing.numero
  end

  def format_created_at
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

end
