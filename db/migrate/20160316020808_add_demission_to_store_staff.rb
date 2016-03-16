class AddDemissionToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :demission, :boolean, default: false
  end
end
