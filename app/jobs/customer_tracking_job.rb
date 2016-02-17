class CustomerTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    customer = StoreCustomer.find(options[:customer_id])

    customer.trackings.create!(
      {
        title: "售后回访",
        content: options[:content],
        category_id: StoreTracking::IDS_CATEGORY['售后回访'],
        contact_way_id: StoreTracking::IDS_CATEGORY['短信'],
        automatic: true,
      }
    )
  end
end
