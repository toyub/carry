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
      SmsJob.perform_later({
        store_id: customer.store.id,
        receiver_type: StoreCustomer.name,
        receiver_id: customer.id,
        content: options[:content],
        first_category: options[:first_category],
        second_category: options[:second_category]
      })
    end
  end
end
