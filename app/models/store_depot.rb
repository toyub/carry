class StoreDepot  < ActiveRecord::Base
  include BaseModel
  has_many :store_material_inventories
  
  def toggle_useable!
    self.update!(useable: !self.useable)
  end

  def self.current_preferred
    self.where(preferred: true).first
  end

  def binding_material_count
    self.store_material_inventories.count(:id)
  end
end
