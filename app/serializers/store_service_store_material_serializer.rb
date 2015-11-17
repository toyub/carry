# == Schema Information
#
# Table name: store_service_store_materials
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer
#  store_service_id  :integer          not null
#  store_material_id :integer          not null
#

class StoreServiceStoreMaterialSerializer < ActiveModel::Serializer
  attributes :mode, :name, :store_material_id

  def name
    object.store_material.name
  end
end
