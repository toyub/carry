class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    store = Store.find_by_id(options[:store_id])
    if options[:receiver_type].blank? 
      return {success: false, notice: "错误: 接收哲类型错误"}
    end
    unless SmsRecord.receiver_type_available? options[:receiver_type]
      return {success: false, notice: "错误: 接收哲类型错误"}
    end

    if store.blank?
      return {success: false, notice: "错误: 门店不存在"}
    end
    if store.sms_balance.blank?
      return {success: false, notice: "错误: 该门店未充值短信费用"}
    end
    if store.sms_balance.remaining < 0
      return {success: false, notice: "错误: 该门店短信费用不足"}
    end

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
    SmsClient.publish(receiver.phone_number, options[:content])
    store.sms_balance.increase_sent_quantity!(quantity)
    {success: true, notice: "发送成功"}
  end

end
