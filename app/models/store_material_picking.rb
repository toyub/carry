class StoreMaterialPicking < ActiveRecord::Base
  attr_accessor :dest_depot_id
  belongs_to :sotre
  belongs_to :store_chain
  belongs_to :store_staff
  belongs_to :store_supplier
  has_many :items, class_name: 'StoreMaterialPickingItem'

  accepts_nested_attributes_for :items

  before_save :save_search_keys

  def received!
    self.status = 1
    self.save!
  end
  private
  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',')
  end
end

# == Schema Information
#
# Table name: store_material_pickings
#
#  id                     :integer          not null, primary key
#  store_id               :integer          not null
#  store_chain_id         :integer          not null
#  store_staff_id         :integer          not null
#  numero                 :string(45)
#  total_quantity         :integer
#  total_amount           :decimal(10, 2)
#  total_inventory_amount :decimal(10, 2)
#  remark                 :string(255)
#  search_keys            :string(255)
#  status                 :integer          default(0)
#  created_at             :datetime
#  updated_at             :datetime
#
