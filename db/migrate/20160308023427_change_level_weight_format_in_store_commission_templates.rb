class ChangeLevelWeightFormatInStoreCommissionTemplates < ActiveRecord::Migration
  def change
    change_column :store_commission_templates, :level_weight_hash, 'json USING CAST(level_weight_hash AS json)', default: {}
  end
end
