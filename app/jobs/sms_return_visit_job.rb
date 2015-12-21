class SmsReturnVisitJob < ActiveJob::Base
  queue_as :default

  # SmsReturnVisitJob.perform_later(option)
  # option = {
  #   customer_id: 72
  #   content: "what do you wanna say"
  #   type_id: "1"
  #   type: "notify"
  # }
  def perform(option)
    customer = StoreCustomer.find(option[:customer_id])
    SmsClient.publish(customer.phone_number, option[:content])
    SmsRecord.create!({
      phone: customer.phone_number,
      customer_name: customer.name,
      content: option[:content]
      type: option[:type]
      type_id: option[:type_id]
      quantity: (option[:content].size / 70).ceil
    })
  end
end
