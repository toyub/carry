class OrderTrackingJob < ActiveJob::Base
  queue_as :order_tracking

  def perform(order)
    order.items.each do |item|
      item.orderable.trackings.each do |tracking|
        options = {
          store_id:         order.store_id,
          customer_id:      order.store_customer_id,
          content:          tracking.content,
          first_category:   "回访",
          second_category:  1
        }
        SmsJob.set(wait: tracking.delay_interval).perform_later(options)
      end
    end
  end
end
