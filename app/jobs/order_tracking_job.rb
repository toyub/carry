class OrderTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    order.items.each do |item|
      switch_id = SmsSwitchType.find_by_name(item.orderable_type).id
      next unless StoreSwitch.by_type(item.orderable_type, switch_id).first.enabled
      item.orderable.trackings.each do |tracking|
        options = {
          store_id:         order.store_id,
          customer_id:      order.store_customer_id,
          content:          tracking.content,
          first_category:   "SmsTrackingSwitchType",
          second_category:  switch_id
        }
        SmsJob.set(wait: tracking.delay_until).perform_later(options)
      end
    end
  end
end
