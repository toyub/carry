class StoreMaterialSaleinfo  <  ActiveRecord::Base

  include BaseModel

  belongs_to :store_material_saleinfo_category
  belongs_to :store_material
  belongs_to :saleman_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'
  has_many :services, class_name:'StoreMaterialSaleinfoService'

  accepts_nested_attributes_for :services

  def divide_unit_type
    MaterialDivideUnitType.find(self.unit).try(:name)
  end

  def cost_price_per_unit
    if self.volume.to_f > 0
      (self.store_material.cost_price.to_f / self.volume.to_f).round(2)
    else
      '-'
    end
  end
end
