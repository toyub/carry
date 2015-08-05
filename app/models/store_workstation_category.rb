class StoreWorkstationCategory < ActiveRecord::Base
  include BaseModel

  has_many :store_workstations
end

# == Schema Information
#
# Table name: store_workstation_categories
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  name           :string(45)
#
