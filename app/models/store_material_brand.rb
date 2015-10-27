class StoreMaterialBrand < ActiveRecord::Base
  include BaseModel

end

# == Schema Information
#
# Table name: store_material_brands
#
#  id             :integer          not null, primary key
#  store_id       :integer
#  store_chain_id :integer
#  store_staff_id :integer
#  name           :string(45)
#  created_at     :datetime
#  updated_at     :datetime
#
