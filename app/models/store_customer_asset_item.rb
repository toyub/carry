class StoreCustomerAssetItem < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true
  belongs_to :store_customer
  has_many :logs, class_name: "StoreCustomerAssetLog"
  belongs_to :store
  belongs_to :store_customer_asset

  def left_quantity
    total_quantity.to_i - used_quantity.to_i
  end

end
