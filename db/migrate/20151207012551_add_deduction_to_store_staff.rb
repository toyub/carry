class AddDeductionToStoreStaff < ActiveRecord::Migration
  def change
    add_column :store_staff, :deduction, :boolean, default: false
  end
end
