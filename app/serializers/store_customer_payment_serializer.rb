class StoreCustomerPaymentSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_customer_id,
                    :store_customer_debit_id, :payment_method,
                    :subject, :amount, :created_at, :updated_at, :store_order_id, :store_staff_id
end