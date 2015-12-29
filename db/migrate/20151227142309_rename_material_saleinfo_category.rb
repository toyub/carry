class RenameMaterialSaleinfoCategory < ActiveRecord::Migration
  def change
    rename_column :store_material_saleinfos, :store_material_saleinfo_category_id, :sale_category_id
  end
end
