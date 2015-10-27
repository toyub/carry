class StoreMaterialSaleinfoCategory < ActiveRecord::Base
  has_many :store_material_saleinfos
end

# == Schema Information
#
# Table name: store_material_saleinfo_categories
#
#  id                         :integer          not null, primary key
#  store_id                   :integer          not null
#  store_chain_id             :integer          not null
#  store_staff_id             :integer          not null
#  store_material_category_id :integer
#  name                       :string(45)       not null
#  created_at                 :datetime
#  updated_at                 :datetime
#
