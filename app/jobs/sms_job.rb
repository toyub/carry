class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    store = Store.find_by_id(options[:store_id])
    if store.sms_balance.present? && (store.sms_balance.remaining > 0)
      receiver = options[:receiver_type].constantize.find(options[:receiver_id])
      quantity = (options[:content].size / 70).ceil + 1
      store.sms_records.create!({
        phone_number: receiver.phone_number,
        receiver_name: receiver.full_name,
        receiver_id: receiver.id,
        receiver_type: options[:receiver_type],
        content: options[:content],
        first_category: options[:first_category],
        second_category: options[:second_category],
        quantity: quantity
      })
      # SmsClient.publish(options[:phone_number], options[:content])
      store.sms_balance.increase_sent_quantity!(quantity)
      {status: 'success', notice: "sending message successfully"}
    else
      {status: 'fails', notice: "Error: There is no capability of sending message"}
    end
  end
end
