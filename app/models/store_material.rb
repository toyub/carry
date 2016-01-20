class StoreMaterial < ActiveRecord::Base
  include BaseModel

  validates :store_material_root_category_id,
            :store_material_category_id,
            :store_material_unit_id,
            :store_material_manufacturer_id,
            :store_material_brand_id,
            :name,
            presence: true

  belongs_to :store_material_unit
  belongs_to :store_material_brand
  belongs_to :store_material_category
  belongs_to :store_material_root_category, class_name: 'StoreMaterialCategory', foreign_key: 'store_material_root_category_id'
  belongs_to :store_material_manufacturer

  has_one :store_material_saleinfo
  has_one :store_material_tracking

  has_many :store_material_inventories
  has_many :store_material_orders
  has_many :snapshots, class_name: "StoreMaterialSnapshot", foreign_key: :store_material_id

  #has_many :store_material_images, foreign_key: 'host_id'
  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_many :store_package_items, as: :package_itemable

  has_many :incomes, class_name: "StoreMaterialIncome"
  has_many :outgos, class_name: "StoreMaterialOutgo"

  scope :name_contains, -> (name) {where("store_materials.name like ?", "%#{name}%")}
  scope :by_sub_category, -> (category) {where(store_material_category_id: category) if category.present?}
  scope :by_primary_category, -> (category) {where(store_material_root_category_id: category) if category.present? }
  scope :keyword, -> (keyword){ where('name like :keyword', keyword: "%#{keyword}%") if keyword.present?  }
  scope :saleable, -> { where(permitted_to_saleable: true) }
  scope :by_saleinfo, -> (id){ where(id: id) }

  after_create :generate_barcode!

  CURRENT_MONTH = Date.today.strftime("%Y%m")

  def inventory(depot_id=nil)
    count_scope = self.store_material_inventories
    count_scope = count_scope.where(store_depot_id: depot_id) if depot_id.present?
    count_scope.sum(:quantity)
  end

  def price
    self.cost_price
  end

  def root_category
    self.store_material_root_category.try(:name)
  end

  def category
    self.store_material_category.try(:name)
  end

  def category_id
    self.store_material_category_id
  end

  def root_category_id
    self.store_material_root_category_id
  end

  def initial_income(prev_month = 1.month.ago.strftime("%Y%m"))
    incomes.where(created_month: prev_month).last
  end

  def current_incomes(month = CURRENT_MONTH)
    incomes.where(created_month: month)
  end

  def current_outgos(month = CURRENT_MONTH)
    outgos.where(created_month: month)
  end

  private
  def generate_barcode!
    unless self.barcode.present?
      self.barcode = "N#{self.id.to_s(36).upcase.rjust(12, '0')}"
      self.save
    end
  end
end
