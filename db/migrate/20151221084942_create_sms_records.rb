class CreateSmsRecords < ActiveRecord::Migration
  def change
    create_table :sms_records do |t|
      t.string :phone
      t.string :customer_name
      t.string :type
      t.integer :type_id
      t.text :content
      t.integer :quantity, default: 1

      t.timestamps null: false
    end
  end
end
