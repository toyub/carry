class StoreCommissionTemplate < ActiveRecord::Base
  include BaseModel

  has_many :sections, class_name: 'StoreCommissionTemplateSection'

  accepts_nested_attributes_for :sections, allow_destroy: true

  def level_weight
    if self.level_weight_hash.present?
      JSON.parse(self.level_weight_hash)
    else
      {}
    end
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
