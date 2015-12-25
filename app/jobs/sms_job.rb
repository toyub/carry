class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    customer = StoreCustomer.find(options[:customer_id])
    SmsRecord.create!({
      phone_number: customer.phone_number,
      customer_name: customer.full_name,
      customer_id: customer.id,
      content: options[:content],
      first_category: options[:first_category],
      second_category: options[:second_category],
      quantity: (options[:content].size / 70).ceil + 1
    })
    SmsClient.publish(customer.phone_number, options[:content])
  end
end
