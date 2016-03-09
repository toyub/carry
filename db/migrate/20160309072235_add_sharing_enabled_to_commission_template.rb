class AddSharingEnabledToCommissionTemplate < ActiveRecord::Migration
  def change
    add_column :store_commission_templates, :sharing_enabled, :boolean, default: false
  end
end
