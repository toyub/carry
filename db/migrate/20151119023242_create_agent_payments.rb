class CreateAgentPayments < ActiveRecord::Migration
  def change
    create_table :agent_payments do |t|
      t.integer :agent_id
      t.integer :quantity
      t.decimal :amount
      t.integer :creator_id
      t.decimal :price
    end
  end
end
