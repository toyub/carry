class AddStoreIdToSmsRecords < ActiveRecord::Migration
  def change
    add_column :sms_records, :store_id, :integer
  end
end
