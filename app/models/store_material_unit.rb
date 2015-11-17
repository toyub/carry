class StoreMaterialUnit < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
end

# == Schema Information
#
# Table name: store_material_units
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  name           :string(45)
#  created_at     :datetime
#  updated_at     :datetime
#
