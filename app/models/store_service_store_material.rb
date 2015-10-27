class StoreServiceStoreMaterial < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_service
  belongs_to :store_material

  validates :store_material_id, presence: true
  validates :store_material_id, uniqueness: {scope: [:store_service_id, :store_id]}

  before_validation :set_store_attrs

  private
    def set_store_attrs
      self.store_id = self.store_material.store_id
      self.store_chain_id = self.store_material.store_chain_id
    end
end

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
