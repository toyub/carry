class StorePackageItem < ActiveRecord::Base
  include BaseModel

  belongs_to :package_itemable, polymorphic: true

  validates :store_package_setting_id, presence: true
  validates :package_itemable_id, presence: true, uniqueness: { scope: [:store_package_setting_id, :package_itemable_type, :store_id] }
  validates :package_itemable_type, presence: true

  before_validation :create_deposit_card, if: :without_itemable_id?

  private
    def create_deposit_card
      package_itemable = StoreDepositCard.create(self.attributes.slice(:price, :denomination, :name))
      self.package_itemable_id = package_itemable.id
    end

    def without_itemable_id?
      self.package_itemable_type.to_s == 'StoreDepositCard' && self.package_itemable_id.blank?
    end
end
