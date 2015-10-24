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
