module Entities
  class MaterialItem < Grape::Entity
    expose(:name) {|model|model.orderable}
  end
  class StoreOrder < Grape::Entity
    expose :id, :numero, :amount, if: {type: :default}
    expose(:full_name, if: {type: :default}) {|model| model.store_customer.full_name}
    expose(:license_number, if: {type: :default}) {|model| model.store_vehicle.vehicle_plates.last.try(:plate).try(:license_number)}
    expose(:phone_number, if: {type: :default}) {|model| model.store_customer.phone_number}
    expose :state, :state_i18n, :pay_status_i18n, :pay_status,
           :task_status, :task_status_i18n, if: {type: :default}

    expose(:item_id, if: {type: :full}) {|model|model.id}
    expose(:order_amount, if: {type: :full}) {|model|model.store_order.amount}
    expose :orderable_type, :orderable_id, :from_customer_asset, :discount,
           :discount_reason, :vip_price, :quantity, :package_type, :package_id,
           :assetable_type, :assetable_id, :store_customer_asset_item_id, if: {type: :full}
    expose(:name, if: {type: :full}) {|model|model.orderable.name}
    expose(:speci, if: {type: :full}) {|model| model.orderable.speci if model.orderable_type == 'StoreMaterial'}
    expose(:price, if: {type: :full}) {|model|model.retail_price}
    expose(:standard_time, if: {type: :full}) {|model|model.orderable.try(:standard_time)}
  end
end
