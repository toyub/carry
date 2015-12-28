class AddRegularToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :regular, :boolean, default: true
    change_column_default :store_staff, :trial_period, nil
  end
end
