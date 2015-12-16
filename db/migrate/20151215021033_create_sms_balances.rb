class CreateSmsBalances < ActiveRecord::Migration
  def change
    create_table :sms_balances do |t|
      t.string  :party_type
      t.integer :party_id
      t.integer :total,                   default: 0
      t.decimal :total_fee,               default: 0
      t.integer :sent_quantity,           default: 0

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
