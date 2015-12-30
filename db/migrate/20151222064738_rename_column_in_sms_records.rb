class RenameColumnInSmsRecords < ActiveRecord::Migration
  def change
    rename_column :sms_records, :switch_type, :first_category
    rename_column :sms_records, :switch_type_index, :second_category
  end
end
