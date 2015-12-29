class AddCreditBillAmountToStoreCustomerSettlements < ActiveRecord::Migration
  def change
    add_column :store_customer_settlements, :credit_bill_amount, :decimal, null: false, default: 0, precision: 10, scale: 2
  end
end
