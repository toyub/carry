class StoreCommissionTemplate < ActiveRecord::Base
  include BaseModel

end

# == Schema Information
#
# Table name: store_commission_templates
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  name              :string(45)
#  aim_to            :integer
#  confined_to       :integer
#  mode_id           :integer
#  level_weight_hash :string(100)
#  status            :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#
