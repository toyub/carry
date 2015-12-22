class AddBonusToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :bonus, :json
  end
end
