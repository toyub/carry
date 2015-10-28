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
end

# == Schema Information
#
# Table name: store_service_workflows
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  store_id         :integer          not null
#  store_chain_id   :integer          not null
#  store_staff_id   :integer          not null
#  engineer_level   :integer
#  engineer_count   :integer
#  position_mode    :integer
#  standard_time    :integer
#  buffering_time   :integer
#  factor_time      :integer
#  store_service_id :integer          not null
#
