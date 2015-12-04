class AddFullNameToStoreStaff < ActiveRecord::Migration
  def change

      add_column :store_staff, :full_name,                           :string
      add_column :store_staff, :phone_number,                  :string
      add_column :store_staff, :mis_login_enabled,            :bool,            default: false
      add_column :store_staff, :app_login_enabled,           :bool,            default: false
      add_column :store_staff, :erp_login_enabled,            :bool,            default: false

  end
end
