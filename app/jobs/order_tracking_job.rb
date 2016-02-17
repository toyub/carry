class OrderTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    order.items.each do |item|
      next unless StoreSwitch.by_switchable_type("SmsTrackingSwitchType").enabled? item.orderable_type
      service_tracking(order, item.orderable.services) if item.orderable == "StoreMaterialSaleinfo" && item.orderable.service_needed && item.orderable.services.present?
      item.orderable.trackings.each do |tracking|
        options = {
          store_id:         order.store_id,
          customer_id:      order.store_customer_id,
          content:          tracking.content,
          first_category:   "SmsTrackingSwitchType",
          second_category:  StoreSwitch::SaleCategory[item.orderable_type.to_sym]
        }
        SmsJob.set(wait: tracking.delay_until).perform_later(options)
        CustomerTrackingJob.set(wait: tracking.delay_until).perform_later(options)
      end
    end
  end

  private
  def service_tracking(order, trackings)
    trackings.each do |tracking|
      next unless tracking.tracking_needed
      options = {
        store_id:         order.store_id,
        customer_id:      order.store_customer_id,
        content:          tracking.tracking_content,
        first_category:   "SmsTrackingSwitchType",
        second_category:  1
      }
      SmsJob.set(wait: tracking.delay_until).perform_later(options)
      CustomerTrackingJob.set(wait: tracking.delay_until).perform_later(options)
  end
end
