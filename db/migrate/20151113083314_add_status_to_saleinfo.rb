class AddStatusToSaleinfo < ActiveRecord::Migration
  def change
    add_column :store_material_saleinfo_services, :deleted, :boolean, default: false
    add_column :store_material_tracking_sections, :deleted, :boolean, default: false
  end
end
