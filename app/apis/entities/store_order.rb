module Entities
  class StoreOrderItem < Grape::Entity
    expose(:item_id) {|model|model.id}
    expose :orderable_type, :orderable_id, :from_customer_asset, :discount,
           :discount_reason, :vip_price, :quantity, :package_type, :package_id,
           :assetable_type, :assetable_id, :store_customer_asset_item_id
    expose(:name) {|model|model.orderable.name}
    expose(:speci) {|model| model.orderable.speci if model.orderable_type == 'StoreMaterialSaleinfo'}
    expose(:price) {|model|model.retail_price}
    expose(:standard_time) {|model|model.orderable.try(:standard_time)}
  end

  class MaterialItem < Grape::Entity
    expose(:name) {|model|model.orderable}
  end
  class StoreOrder < Grape::Entity
    expose :id, :numero, :amount, :store_customer_id
    expose :only_today, :human_readable_status, if: {type: :default}
    expose(:full_name, if: {type: :default}) {|model| model.store_customer.full_name}
    expose(:license_number, if: {type: :default}) {|model| model.store_vehicle.vehicle_plates.last.try(:plate).try(:license_number)}
    expose(:phone_number, if: {type: :default}) {|model| model.store_customer.phone_number}
    expose :state, :state_i18n, :pay_status_i18n, :pay_status,
           :task_status, :task_status_i18n, if: {type: :default}
    expose(:state_to_i, if: {type: :default}) {|model| ActiveRecord::Base::StoreOrder.states[:"#{model.state}"]}
    expose(:pay_status_to_i, if: {type: :default}) {|model| ActiveRecord::Base::StoreOrder.pay_statuses[:"#{model.pay_status}"]}
    expose(:task_status_to_i, if: {type: :default}) {|model| ActiveRecord::Base::StoreOrder.task_statuses[:"#{model.task_status}"]}

    expose :items, using: StoreOrderItem, if: {type: :full}

    def date
      Date.today
    end

    def only_today
      object.created_at.to_date.between?(date.beginning_of_day, date.end_of_day)
    end
  end
end
