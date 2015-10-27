# == Schema Information
#
# Table name: store_material_categories
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  parent_id      :integer          default(0), not null
#  name           :string(45)
#  created_at     :datetime
#  updated_at     :datetime
#

class StoreMaterialCategorySerializer < ActiveModel::Serializer
  attributes :id, :store_id, :parent_id, :name

  has_many :sub_categories
end
