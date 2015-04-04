class StoreMaterialOrderItem < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material
  has_many :store_material_inventories

  attr_accessor :checked
end
