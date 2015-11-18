class AddSalemanCommissionTemplateIdToStoreMaterialSaleinfos < ActiveRecord::Migration
  def change
    add_column :store_material_saleinfos, :saleman_commission_template_id, :integer
  end
end
