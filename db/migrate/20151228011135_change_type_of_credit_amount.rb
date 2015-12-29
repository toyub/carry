class ChangeTypeOfCreditAmount < ActiveRecord::Migration
  def change
    add_column :store_customer_settlements, :credit_limit, :decimal, precision: 12, scale: 2, default: 0.0
    remove_column :store_customer_settlements, :credit_amount, :string
    add_column :store_customer_entities, :points, :integer
  end
end
