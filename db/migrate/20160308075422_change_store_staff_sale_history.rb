class ChangeStoreStaffSaleHistory < ActiveRecord::Migration
  def change
    remove_column :store_staff_sale_histories, :order_quantity
    remove_column :store_staff_sale_histories, :order_amount
    remove_column :store_staff_sale_histories, :item_quantity
    remove_column :store_staff_sale_histories, :item_amount
    remove_column :store_staff_sale_histories, :material_quantity
    remove_column :store_staff_sale_histories, :material_amount
    remove_column :store_staff_sale_histories, :service_quantity
    remove_column :store_staff_sale_histories, :service_amount
    remove_column :store_staff_sale_histories, :package_quantity
    remove_column :store_staff_sale_histories, :package_amount
    remove_column :store_staff_sale_histories, :task_quantity
    remove_column :store_staff_sale_histories, :commission_amount
    add_column :store_staff_sale_histories, :ownerable_type, :string
    add_column :store_staff_sale_histories, :ownerable_id, :integer
    rename_table :store_staff_sale_histories, :store_commissions
  end
end
