class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  belongs_to :store_customer
  has_many :logs, class_name: "StoreCustomerAssetLog"

  def left_quantity
    total_quantity - used_quantity
  end

end
