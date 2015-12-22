class CreateSmsRecords < ActiveRecord::Migration
  def change
    create_table :sms_records do |t|
      t.string :phone_number
      t.string :customer_name
      t.integer :customer_id
      t.string :switch_type
      t.integer :switch_type_index
      t.text :content
      t.integer :quantity, default: 1

      t.timestamps null: false
    end
  end
end
