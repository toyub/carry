class AddQuantityToStoreMaterialSaleinfoServices < ActiveRecord::Migration
  def change
    add_column :store_material_saleinfo_services, :quantity, :integer
  end
end
