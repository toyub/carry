class CreateStorePayments < ActiveRecord::Migration
  def up
    create_table :store_payments do |t|
      t.integer :staffer_id
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :renewal_type_id
      t.datetime :paid_at
      t.decimal :amount, precision: 10, scale: 2
      t.integer :payment_type_id
      t.integer :invoice_type_id
      t.boolean :receipt_required
      t.string :remark

      t.datetime :created_at
      t.datetime :updated_at
    end

    drop_table :store_renewal_records
  end

  def down
    drop_table :store_payments

    create_table :store_renewal_records do |t|
      t.integer :staffer_id
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :renewal_type_id
      t.datetime :paid_at
      t.decimal :amount, precision: 10, scale: 2
      t.integer :payment_type_id
      t.integer :invoice_type_id
      t.boolean :receipt_required
      t.string :remark

      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
