class StorePackageItem < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package_setting
  belongs_to :package_itemable, polymorphic: true
  has_many :store_order_items, as: :package_item

  before_validation :create_deposit_card, if: :without_itemable_id?

  scope :deposits_cards, ->{where(package_itemable_type: StoreDepositCard.name)}
  scope :packaged_services, ->{where(package_itemable_type: StoreService.name)}
  scope :packaged_materials, ->{where(package_itemable_type: StoreMaterialSaleinfo.name)}

  def name
    read_attribute(:name) || package_itemable.try(:name)
  end

  def retail_price
    package_itemable.retail_price
  end

  private
    def create_deposit_card
      package_itemable = StoreDepositCard.create(self.attributes.slice(:price, :denomination, :name))
      self.package_itemable_id = package_itemable.id
    end

    def without_itemable_id?
      self.package_itemable_type.to_s == 'StoreDepositCard' && self.package_itemable_id.blank?
    end
end
