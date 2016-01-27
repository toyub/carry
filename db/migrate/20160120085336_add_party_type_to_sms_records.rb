class AddPartyTypeToSmsRecords < ActiveRecord::Migration
  def change
    add_column :sms_records, :party_type, :string
    add_column :sms_records, :party_id, :integer
  end
end
