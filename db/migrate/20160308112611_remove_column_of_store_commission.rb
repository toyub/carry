class RemoveColumnOfStoreCommission < ActiveRecord::Migration
  def change
    remove_column :store_commissions, :store_staff_id
  end
end
