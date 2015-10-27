class StoreDepot  < ActiveRecord::Base
  belongs_to :store
  has_many :store_material_inventories
end

# == Schema Information
#
# Table name: store_depots
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  name           :string(45)
#  created_at     :datetime
#  updated_at     :datetime
#
