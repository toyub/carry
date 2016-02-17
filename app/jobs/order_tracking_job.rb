class OrderTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    order.items.each do |item|
      item.orderable.trackings.each do |tracking|

        sms_type = 0
        sms_type = 1 if item.orderable_type == "StoreMaterialSaleinfo"
        sms_type = 2 if item.orderable_type == "StorePackage"

        options = {
          store_id:         order.store_id,
          customer_id:      order.store_customer_id,
          content:          tracking.content,
          first_category:   "SmsTrackingSwitchType",
          second_category:  sms_type
        }
        SmsJob.set(wait: tracking.delay_until).perform_later(options)
      end
    end
  end
end
