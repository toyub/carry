class StoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :works, :json
  end
end
