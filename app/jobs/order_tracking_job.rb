class OrderTrackingJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    order.items.each do |item|
      switch =  case item.orderable_type
                when StoreMaterialSaleinfo.name
                  order.store.store_switches.by_switchable(SmsTrackingSwitchType.find_by_name("商品售后回访")).first
                when StoreService.name
                  order.store.store_switches.by_switchable(SmsTrackingSwitchType.find_by_name("服务售后回访")).first
                when StorePackage.name
                  order.store.store_switches.by_switchable(SmsTrackingSwitchType.find_by_name("套餐售后回访")).first
                else
                  nil
                end
      if switch.present? && switch.enabled?
        service_tracking(order, item, item.orderable.services) if item.orderable == StoreMaterialSaleinfo.name && item.orderable.service_needed && item.orderable.services.present?
        if item.orderable.trackings.present?
          item.orderable.trackings.each do |tracking|
            options = {
              store_id:              order.store_id,
              store_order_id:        order.id,
              store_order_item_id:   item.id,
              customer_id:           order.store_customer_id,
              content:               tracking.content,
              first_category:        SmsTrackingSwitchType.name,
              second_category:       switch.switchable_id
            }
            CustomerTrackingJob.set(wait: tracking.delay_until).perform_later(options)
          end
        end
      end
    end
  end

  private
  def service_tracking(order, item, trackings)
    trackings.each do |tracking|
      next unless tracking.tracking_needed
      options = {
        store_id:              order.store_id,
        store_order_id:        order.id,
        store_order_item_id:   item.id,
        customer_id:           order.store_customer_id,
        content:               tracking.tracking_content,
        first_category:        SmsTrackingSwitchType.name,
        second_category:       StoreSwitch::SaleCategory[item.orderable_type.to_sym]
      }
      CustomerTrackingJob.set(wait: tracking.delay_until).perform_later(options)
    end
  end
end
