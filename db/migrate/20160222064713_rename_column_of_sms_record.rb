class RenameColumnOfSmsRecord < ActiveRecord::Migration
  def change
    rename_column :sms_records, :customer_name, :receiver_name
    rename_column :sms_records, :customer_id, :receiver_id
    add_column :sms_records, :receiver_type, :string
  end
end
