class ChangeStoreStaffCommissionHistories < ActiveRecord::Migration
  def change
    add_column :store_staff_commission_histories, :orderable_type, :string
    add_column :store_staff_commission_histories, :ownerable_type, :string
    add_column :store_staff_commission_histories, :ownerable_id, :integer
    add_column :store_staff_commission_histories, :store_commission_id, :integer
    rename_table :store_staff_commission_histories, :store_commission_items
  end
end
