class StoreDepot  < ActiveRecord::Base
  include BaseModel
  has_many :store_material_inventories

  default_scope {where(deleted: false).order('id asc')}

  def material_types_count
    self.store_material_inventories.count(:id)
  end
  
  def toggle_useable!
    self.update!(useable: !self.useable)
  end

  def self.current_preferred
    self.where(preferred: true).first
  end

  def binding_material_count
    self.store_material_inventories.where('quantity > 0').count(:id)
  end
end
