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

class StoreWorkstationSerializer < ActiveModel::Serializer
  attributes :id, :name
end
