class StoreCommissionTemplate < ActiveRecord::Base
  include BaseModel

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
