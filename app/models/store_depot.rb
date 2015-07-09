class StoreDepot  < ActiveRecord::Base
  belongs_to :store
  has_many :store_material_inventories
end
