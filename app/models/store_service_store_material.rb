class StoreServiceStoreMaterial < ActiveRecord::Base
  belongs_to :store_service
  belongs_to :store_material
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_staff

  validates :store_staff_id, presence: true
  validates :store_chain_id, presence: true
  validates :store_id, presence: true
  validates :store_service_id, presence: true
  validates :store_material_id, presence: true
  validates :store_material_id, uniqueness: {scope: [:store_service_id, :store_id]}
end
