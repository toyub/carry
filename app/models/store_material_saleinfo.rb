class StoreMaterialSaleinfo  <  ActiveRecord::Base

  include BaseModel

  belongs_to :sale_category
  belongs_to :store_material
  belongs_to :saleman_commission_template,
                          class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'

  has_many :services, class_name:'StoreMaterialSaleinfoService', dependent: :delete_all
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :orderable
  has_many :recommended_order_items, as: :itemable

  scope :by_category, ->(sale_category_id){ where(sale_category_id: sale_category_id) if sale_category_id.present? }

  accepts_nested_attributes_for :services

  delegate :name, to: :store_material

  def divide_unit_type
    MaterialDivideUnitType.find(self.divide_unit_type_id).try(:name)
  end

  def cost_price_per_unit
    if self.divide_total_volume.present?
      (self.store_material.cost_price.to_f / self.divide_total_volume.to_f).round(2)
    else
      self.store_material.cost_price.to_f
    end
  end

  def cost_price
    if self.divide_to_retail
      cost_price_per_unit
    else
      self.store_material.cost_price
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
