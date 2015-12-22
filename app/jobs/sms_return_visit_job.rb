class SmsReturnVisitJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    customer = StoreCustomer.find(options[:customer_id])
    SmsClient.publish(customer.phone_number, options[:content])
    SmsRecord.create!({
      phone_number: customer.phone_number,
      customer_name: customer.full_name,
      customer_id: customer.id,
      content: options[:content],
      switch_type: options[:switch_type],
      switch_type_index: options[:switch_type_index],
      quantity: (options[:content].size / 70).ceil + 1
    })
  end
end
