class AddVipPriceEnabledToStoreServices < ActiveRecord::Migration
  def change
    add_column :store_services, :saleman_commission_template_id, :integer
    add_column :store_services, :vip_price_enabled, :boolean, default: false
  end
end
