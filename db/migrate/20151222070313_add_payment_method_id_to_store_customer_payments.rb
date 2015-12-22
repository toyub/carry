class AddPaymentMethodIdToStoreCustomerPayments < ActiveRecord::Migration
  def change
    add_column :store_customer_payments, :payment_method_id, :integer, null: false, default: 0
    add_column :store_customer_payments, :store_order_id, :integer
    add_column :store_customer_payments, :store_staff_id, :integer
  end
end
