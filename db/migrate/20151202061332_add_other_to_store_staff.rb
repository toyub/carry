class AddOtherToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :other, :json
  end
end
