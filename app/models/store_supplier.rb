class StoreSupplier < ActiveRecord::Base
  has_many :store_material_orders
  
end
