class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :staffer_id
      t.integer :order_id
      t.string  :party_type
      t.integer :party_id
      t.decimal :amount,                      precision: 10,              scale: 2
      t.string  :payment_method
      t.json    :third_party_params

      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end
