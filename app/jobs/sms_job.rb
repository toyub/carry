class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    store = Store.find(options[:store_id])
    if store.sms_balance.present? && (store.sms_balance.remaining > 0)
      customer = StoreCustomer.find(options[:customer_id])
      quantity = (options[:content].size / 70).ceil + 1
      store.sms_records.create!({
        phone_number: customer.phone_number,
        customer_name: customer.full_name,
        customer_id: customer.id,
        content: options[:content],
        first_category: options[:first_category],
        second_category: options[:second_category],
        quantity: quantity
      })
      SmsClient.publish(customer.phone_number, options[:content])
      store.sms_balance.increase_sent_quantity!(quantity)
    end
  end
end
