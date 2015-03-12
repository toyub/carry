class Store <  ActiveRecord::Base
  belongs_to :store_chain
  has_many :store_materials
  has_many :store_material_category
  has_many :store_material_unit
  validates :name, presence: true

end
