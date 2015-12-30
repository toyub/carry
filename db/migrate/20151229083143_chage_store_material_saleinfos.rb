class ChageStoreMaterialSaleinfos < ActiveRecord::Migration
  def change
    change_column_null :store_material_saleinfos, :bargain_price, true
    change_column_null :store_material_saleinfos, :retail_price, true
    change_column_null :store_material_saleinfos, :trade_price, true

    rename_column      :store_material_saleinfos, :unit,   :divide_unit_type_id
    rename_column      :store_material_saleinfos, :volume, :divide_total_volume

    add_column         :store_material_saleinfos, :divide_volume_per_bill, :decimal, precision: 10, scale: 2
  end
end
