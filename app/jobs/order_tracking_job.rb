class OrderTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    order.items.each do |item|
      next unless StoreSwitch.by_switchable_type("SmsTrackingSwitchType").enabled? item.orderable_type
      item.orderable.trackings.each do |tracking|
        options = {
          store_id:         order.store_id,
          customer_id:      order.store_customer_id,
          content:          tracking.content,
          first_category:   "SmsTrackingSwitchType",
          second_category:  StoreSwitch::SaleCategory[item.orderable_type.to_sym]
        }
        SmsJob.set(wait: tracking.delay_until).perform_later(options)
      end
    end
  end
end
