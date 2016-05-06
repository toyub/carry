class StorePackageItem < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package_setting
  belongs_to :package_itemable, polymorphic: true
  has_many :store_order_items, as: :package_item

  before_save :create_deposit_card, :if :need_create_new_deposit_card?

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
      package_itemable = StoreDepositCard.create(self.attributes.symbolize_keys.slice(:price, :denomination, :name, :store_staff_id))
      self.package_itemable_id = package_itemable.id
      package_itemable
    end

    def need_create_new_deposit_card?
      (self.package_itemable_type == StoreDepositCard.name) && (self.package_itemable_id.blank? || self.package_itemable.blank?)
    end
end
