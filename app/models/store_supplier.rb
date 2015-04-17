class StoreSupplier < ActiveRecord::Base
  has_many :store_material_orders
  belongs_to :store
  belongs_to :store_chain
end
