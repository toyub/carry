json.(@setting, :id, :retail_price, :period, :period_unit, :period_enable, :expired_notice_required, :before_expired, :store_commission_template_id, :apply_range, :point, :payment_mode)
json.items @setting.items, :id, :package_itemable_id, :package_itemable_type, :denomination, :price, :name, :quantity, :amount
