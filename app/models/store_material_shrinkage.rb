class StoreMaterialShrinkage < ActiveRecord::Base
  include BaseModel
  
  has_many :items, class_name: 'StoreMaterialShrinkageItem'
  accepts_nested_attributes_for :items

  before_save :save_search_keys

  private
  def save_search_keys
    self.search_keys = self.items.map(&->(item){item.store_material.name}).join(',')
  end
end
<<<<<<< HEAD

# == Schema Information
#
# Table name: store_material_shrinkages
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  numero         :string(45)
#  total_quantity :integer          default(0)
#  total_amount   :decimal(10, 2)   default(0.0)
#  remark         :string(255)
#  search_keys    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#
=======
>>>>>>> development
