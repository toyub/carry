class RenameDeductionInStoreStaff < ActiveRecord::Migration
  def change
    rename_column :store_staff, :deduction, :deduct_enabled
    add_column :store_staff, :deadline_days, :integer
    add_column :store_staff, :contract_notice_enabled, :boolean, default: false
  end
end
