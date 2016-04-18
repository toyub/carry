class ChangeDefaultNullableOfStoreMaterial < ActiveRecord::Migration
  def change
    change_column_null :store_materials, :store_material_root_category_id, true
    change_column_null :store_materials, :store_material_category_id, true
    change_column_null :store_materials, :store_material_unit_id, true
    change_column_null :store_materials, :store_material_manufacturer_id, true
    change_column_null :store_materials, :store_material_brand_id, true
  end
end
