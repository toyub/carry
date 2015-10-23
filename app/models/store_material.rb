class StoreMaterial < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_material_unit
  belongs_to :store_material_brand
  belongs_to :store_material_category
  belongs_to :store_material_root_category, class_name: 'StoreMaterialCategory', foreign_key: 'store_material_root_category_id'
  belongs_to :store_material_manufacturer
  belongs_to :creator, class_name: 'StoreStaff', foreign_key: 'store_staff_id'

  has_many :store_material_commissions
  has_one :smc_salesman
  has_one :smc_mechanic
  has_one :store_material_saleinfo
  has_one :store_material_tracking

  has_many :store_material_inventories
  has_many :store_material_orders
  has_many :snapshots, class_name: "StoreMaterialSnapshot", foreign_key: :store_material_id

  #has_many :store_material_images, foreign_key: 'host_id'
  has_many :uploads, class_name: '::Upload::StoreMaterial', as: :fileable

  scope :name_contains, -> (name) {where("store_materials.name like ?", "%#{name}%")}
  scope :by_sub_category, -> (category) {where(store_material_category_id: category) if category.present?}
  scope :by_primary_category, -> (category) {where(store_material_root_category_id: category) if category.present? }
  scope :keyword, -> (keyword){ where('name like :keyword', keyword: "%#{keyword}%") if keyword.present?  }

  after_create :generate_barcode!

  def inventory(depot_id=nil)
    count_scope = self.store_material_inventories
    count_scope = count_scope.where(store_depot_id: depot_id) if depot_id.present?
    count_scope.sum(:quantity)
  end

  private
  def generate_barcode!
    unless self.barcode.present?
      self.barcode = format('N%s%s', self.store_id.to_s(36).upcase.rjust(5, '0'), self.id.to_s(36).upcase.rjust(5, '0'))
      self.save
    end
  end
end
