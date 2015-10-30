class AddCategoryIdToStoreMaterialSaleInfo < ActiveRecord::Migration
  def change
    add_column :store_material_saleinfos, :store_material_saleinfo_category_id, :integer
  end
end
