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

  scope :available, ->{where(status: 0)}
  scope :for_saleman, -> { where(aim_to: 0) }
  scope :for_machanic, -> { where(aim_to: 1) }

  def level_weight
    self.level_weight_hash
  end

  def mode_type
    CommissionModeType.find(self.mode_id).try(:name)
  end

  def confined_type
    CommissionConfineType.find(self.confined_to).try(:name)
  end

  def aim_type
    CommissionAimType.find(self.aim_to).try(:name)
  end

  def task_commission(item, task, staff, beneficiary = 'person')
    if confined_to == CommissionConfineType::TYPES_ID['部门']
      beneficiary == 'department' ? (account_for(task, staff) * calculate_commission(item)).round(2) : 0.0
    else
      beneficiary == 'person' ? (account_for(task, staff) * calculate_commission(item)).round(2) : 0.0
    end
  end

  def sale_commission(item, staff, beneficiary = 'person')
    if confined_to == CommissionConfineType::TYPES_ID['部门']
      beneficiary == 'department' ? calculate_commission(item).round(2) : 0.0
    else
      beneficiary == 'person' ? calculate_commission(item).round(2) : 0.0
    end
  end

  def account_for(task, staff)
    if sharing_enabled
      base = task.workflow_snapshot.mechanics.map {|mech| level_weight_hash[mech.level_type_id.to_s] }.sum.to_f
      base > 0 ? (level_weight_hash[staff.level_type_id.to_s].to_f / base ) : 0.0
    else
      1
    end
  end

  def calculate_commission(order_item)
    amount = 0.0
    case mode_id
    when 0 #"标准提成"
      section = sections.where(mode_id: mode_id).last
      amount = section.type_id == 0 ? section.amount : (section.amount/100).to_f * order_item.retail_amount
    when 1 #"阶梯提成"
      section = sections.where(mode_id: mode_id).where("min < ?", order_item.quantity).last
      return 0.0 if section.blank?
      amount = section.type_id == 0 ? section.amount : (section.amount/100).to_f * order_item.retail_amount
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
