class CustomerTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    customer = StoreCustomer.find(options[:customer_id])

    if customer.message_accepted
      customer.trackings.create!(
        {
          title: "售后回访",
          store_order_id: options[:store_order_id],
          store_order_item_id: options[:store_order_item_id],
          content: options[:content],
          category_id: StoreTracking::IDS_CATEGORY['售后回访'],
          contact_way_id: StoreTracking::IDS_CATEGORY['短信'],
          automatic: true,
        }
      )
      status = SmsJob.perform_later({
        store_id: customer.store.id,
        receiver_type: StoreCustomer.name,
        receiver_id: customer.id,
        content: options[:content],
        first_category: options[:first_category],
        second_category: options[:second_category]
      })
      if status[:success]
        content = "您设定的回访信息发送成功，内容如下：#{options[:content]}"
        Notifications::TrackingReminder.send_message(content, customer.store.store_staff)
      end
    end
  end
end
