class StoreMaterialInventory < ActiveRecord::Base
  include BaseModel
  belongs_to :store_depot
  belongs_to :store_material
  has_many :store_material_orders
  has_many :store_material_inventory_records

  scope :by_depot, ->(depot_id){where(store_depot_id: depot_id) if depot_id.present?}
  scope :inclmd, ->{includes(:store_material, :store_depot)}

  def returning!(quantity)
    down!(quantity)
  end

  def outing!(quantity)
    down!(quantity)
  end

  def checkin!(quantity)
    up!(quantity)
  end

  private
  def down!(quantity)
    self.class.unscoped.where(id: self.id).update_all("quantity=COALESCE(quantity, 0) - #{quantity.to_i.abs}")
  end

  def up!(quantity)
    self.class.unscoped.where(id: self.id).update_all("quantity=COALESCE(quantity, 0) + #{quantity.to_i.abs}")
  end
end
