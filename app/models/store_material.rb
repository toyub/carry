class StoreMaterial < ActiveRecord::Base
  include BaseModel

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

# == Schema Information
#
# Table name: store_materials
#
#  id                              :integer          not null, primary key
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  store_material_root_category_id :integer          not null
#  store_material_category_id      :integer          not null
#  store_material_unit_id          :integer          not null
#  store_material_manufacturer_id  :integer          not null
#  store_material_brand_id         :integer          not null
#  name                            :string(100)      not null
#  barcode                         :string(45)
#  mnemonic                        :string(45)
#  speci                           :string(45)
#  cost_price                      :decimal(10, 2)
#  min_price                       :decimal(10, 2)
#  inventory_alarmify              :boolean          default(FALSE)
#  min_inventory                   :integer
#  max_inventory                   :integer
#  expiry_alarmify                 :boolean          default(FALSE)
#  shelf_life                      :integer
#  permitted_to_internal           :boolean          default(TRUE), not null
#  permitted_to_saleable           :boolean          default(FALSE), not null
#  remark                          :text
#  created_at                      :datetime
#  updated_at                      :datetime
#
