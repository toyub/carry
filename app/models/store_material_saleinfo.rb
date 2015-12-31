class StoreMaterialSaleinfo  <  ActiveRecord::Base

  include BaseModel

  belongs_to :sale_category
  belongs_to :store_material
  belongs_to :saleman_commission_template,
                          class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'

  has_many :services, class_name:'StoreMaterialSaleinfoService'
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :orderable

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
    if saleman_commission_template_id.present?
      template = saleman_commission_template
      amount = 0
      case template.mode_id
      when 0 #"标准提成"
        section = template.sections.where(mode_id: template.mode_id).last
        amount = section.type_id == 0 ? section.amount : (section.amount/100).to_f * order_item.amount
      when 1, 2 #"阶梯提成" #"分段提成"
        section = template.sections.where(mode_id: template.mode_id).where("min < ?", order_item.quantity).last
        amount = section.type_id == 0 ? section.amount : (section.amount/100).to_f * order_item.amount
      end
    else
      0.0
    end
  end
end
