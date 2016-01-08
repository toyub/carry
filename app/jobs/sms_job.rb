class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    if current_store.sms_balance.remaining > 0
      customer = StoreCustomer.find(options[:customer_id])
      quantity = (options[:content].size / 70).ceil + 1
      SmsRecord.create!({
        phone_number: customer.phone_number,
        customer_name: customer.full_name,
        customer_id: customer.id,
        content: options[:content],
        first_category: options[:first_category],
        second_category: options[:second_category],
        quantity: quantity
      })
      SmsClient.publish(customer.phone_number, options[:content])
      current_store.sms_balance.increase_sent_quantity!(quantity)
    end
  end
end
