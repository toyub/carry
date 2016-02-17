class CustomerTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(options)
    customer = StoreCustomer.find(options[:customer_id])

    customer.trackings.create!(
      {
        category_id: 3,
        contact_way_id: 1,
        content: options[:content],
        executant_id: 3,
        automatic: true,
      }
    )
  end
end
