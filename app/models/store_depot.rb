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

# == Schema Information
#
# Table name: store_depots
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  name           :string(45)
#  created_at     :datetime
#  updated_at     :datetime
#
