class StoreMaterial < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_material_category
  belongs_to :store_material_unit
end
