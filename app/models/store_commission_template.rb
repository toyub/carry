class StoreCommissionTemplate < ActiveRecord::Base
  include BaseModel

  has_many :sections, class_name: 'StoreCommissionTemplateSection'
  has_one  :mode0_section,  -> {where('store_commission_template_sections.mode_id = 0')},
                            class_name: 'StoreCommissionTemplateSection'
  has_many :mode1_sections, -> {where('store_commission_template_sections.mode_id = 1')},
                            class_name: 'StoreCommissionTemplateSection'
  has_many :mode2_sections, -> {where('store_commission_template_sections.mode_id = 2')},
                            class_name: 'StoreCommissionTemplateSection'

  accepts_nested_attributes_for :sections, allow_destroy: true

  def level_weight
    if self.level_weight_hash.present?
      JSON.parse(self.level_weight_hash)
    else
      {}
    end
  end

  def mode_type
    CommissionModeType.find(self.mode_id).name
  end

  def confined_type
    CommissionConfineType.find(self.confined_to).name
  end

  def aim_type
    CommissionAimType.find(self.aim_to).name
  end

  def commission(order_item)
    amount = 0.0
    case mode_id
    when 0 #"标准提成"
      section = sections.where(mode_id: mode_id).last
      amount = section.type_id == 0 ? section.amount : (section.amount/100).to_f * order_item.amount
    when 1 #"阶梯提成"
      section = sections.where(mode_id: mode_id).where("min < ?", order_item.quantity).last
      amount = section.type_id == 0 ? section.amount : (section.amount/100).to_f * order_item.amount
    when 2 #"分段提成"
      within_secs = sections.where(mode_id: mode_id).where("max < ?", order_item.quantity)
      return 0.0 if within_secs.empty?
      sec = sections.where(mode_id: mode_id).where("max > ?", order_item.quantity).first || within_secs.last
      excess = order_item.quantity - within_secs.last.max

      within_secs.each do |section|
        amount += section.type_id == 0 ? section.amount : (section.amount/100).to_f * section.max
      end
      amount += sec.type_id == 0 ? sec.amount : (sec.amount/100).to_f * excess
    end
  end
end
