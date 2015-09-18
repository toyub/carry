class StoreWorkstation < ActiveRecord::Base
  include BaseModel

  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_workstation_category
end

# == Schema Information
#
# Table name: store_workstations
#
#  id                            :integer          not null, primary key
#  created_at                    :datetime
#  updated_at                    :datetime
#  store_id                      :integer          not null
#  store_chain_id                :integer          not null
#  store_staff_id                :integer          not null
#  name                          :string(45)       not null
#  store_workstation_category_id :integer
#
