class AddMechanicCommissionTemplateIdToStoreMaterialSaleinfoServices < ActiveRecord::Migration
  def change
    add_column :store_material_saleinfo_services, :mechanic_commission_template_id, :integer
  end
end
