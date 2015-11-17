class StoreMaterialOuting < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :requester, class_name: 'StoreStaff'

  has_many :items, class_name: 'StoreMaterialOutingItem'

  accepts_nested_attributes_for :items

  before_save :save_search_keys

  private
  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',')
  end
end

# == Schema Information
#
# Table name: store_material_outings
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  requester_id   :integer
#  outing_type_id :integer
#  numero         :string(45)
#  total_quantity :integer
#  total_amount   :decimal(10, 2)
#  remark         :string(45)
#  search_keys    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#
