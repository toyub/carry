class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  belongs_to :package_item, polymorphic: true
  belongs_to :store_customer
  has_many :logs, class_name: "StoreCustomerAssetLog"
  belongs_to :store
  belongs_to :store_customer_asset

  scope :available, ->{where('total_quantity > used_quantity')}

  def left_quantity
    total_quantity.to_i - used_quantity.to_i
  end

  def name
    assetable.try(:name)
  end

  def service
    case self.assetable_type
    when StoreService.name
      self.assetable
    when StoreMaterialSaleinfoService.name
      self.assetable
    else
      nil
    end
  end

  def orderable_type
    service.try(:class).try :name
  end

  def orderable_id
    service.try :id
  end
end
