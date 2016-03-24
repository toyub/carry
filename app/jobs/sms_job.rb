class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    store = Store.find_by_id(options[:store_id])
    if options[:receiver_type].present? && (SmsRecord.receiver_type_available? options[:receiver_type])
      receiver = options[:receiver_type].constantize.find(options[:receiver_id])
    else
      return {success: false, notice: "Error: Can't find receiver"}
    end
    if store.present? && store.sms_balance.present? && (store.sms_balance.remaining > 0)
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
      SmsClient.publish(receiver.phone_number, options[:content])
      store.sms_balance.increase_sent_quantity!(quantity)
      {success: true, notice: "sending message successfully"}
    else
      {success: false, notice: "Error: There is no capability of sending message"}
    end
  end
end
