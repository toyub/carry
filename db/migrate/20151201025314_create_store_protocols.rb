class CreateStoreProtocols < ActiveRecord::Migration
  def change
    create_table :store_protocols do |t|
      t.text :reason_for
      t.date :effective_date
      t.integer :verifier_id
      t.text :remarks
      t.integer :created_by
      t.date :record_at
      t.date :end_at
      t.string :type
      t.integer :store_staff_id
      t.integer :store_id
      t.integer :store_chain_id

      t.timestamps null: false
    end
  end
end
