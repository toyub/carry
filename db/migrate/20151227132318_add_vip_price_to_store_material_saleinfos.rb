class AddVipPriceToStoreMaterialSaleinfos < ActiveRecord::Migration
  def change
    add_column :store_material_saleinfos, :vip_price, :decimal, precision: 10, scale: 2
  end
end
