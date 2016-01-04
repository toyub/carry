class StoreMaterialSaleinfo  <  ActiveRecord::Base

  include BaseModel

  belongs_to :sale_category
  belongs_to :store_material
  belongs_to :saleman_commission_template,
                          class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'

  has_many :services, class_name:'StoreMaterialSaleinfoService', dependent: :delete_all
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :orderable

  accepts_nested_attributes_for :services

  delegate :name, to: :store_material

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

  def point
    self.reward_points
  end

  def commission(order_item)
    saleman_commission_template.present? ? saleman_commission_template.commission(order_item) : 0.0
  end

  def to_snapshot!(order_item)
    self.services.each do |service|
      service.to_snapshot!(order_item)
    end
  end
end
