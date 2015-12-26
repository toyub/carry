class RemovePaymentTypeIdFromStoreCustomerPayments < ActiveRecord::Migration
  def change
    remove_column :store_customer_payments, :payment_method_id, :integer
  end
end
