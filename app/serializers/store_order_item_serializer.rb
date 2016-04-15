class StoreOrderItemSerializer < ActiveModel::Serializer
  attributes  :id, :store_id, :store_chain_id, :store_staff_id, :store_order_id, :store_customer_id,
              :orderable_id,:orderable_type, :name, :speci,
              :cost_price, :retail_price, :vip_price, :discount, :price,
              :quantity, :amount,
              :discount_reason, :remark,
              :divide_to_retail, :standard_volume_per_bill, :actual_volume_per_bill, :divide_cost_checked,
              :from_customer_asset, :store_customer_asset_item_id, :package_type, :package_id, :assetable_type, :assetable_id,
              :created_at, :updated_at

  def name
    object.orderable.try(:name)
  end

  def speci
    if object.orderable_type == "StoreMaterialSaleinfo"
      object.orderable.store_material.speci
    else
      ""
    end
  end
end
