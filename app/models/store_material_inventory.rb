class StoreMaterialInventory < ActiveRecord::Base
  include BaseModel
  belongs_to :store_depot
  belongs_to :store_material
  has_many :store_material_orders
  has_many :store_material_inventory_records

  scope :by_depot, ->(depot_id){where(store_depot_id: depot_id) if depot_id.present?}
  scope :by_sub_category, -> (category) {where("store_materials.store_material_category_id = ?", category) if category.present?}
  scope :by_primary_category, -> (category) {where("store_materials.store_material_root_category_id = ?", category) if category.present? }
  scope :keyword, -> (keyword){ where('store_materials.name like :keyword', keyword: "%#{keyword}%") if keyword.present?  }

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
