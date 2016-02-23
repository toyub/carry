module Entities
  class MaterialItem < Grape::Entity
    expose(:name) {|model|model.orderable}
  end
  class StoreOrder < Grape::Entity
    expose :id, :numero, :amount, :pay_status, if: {type: :default}
    expose(:full_name, if: {type: :default}) {|model| model.store_customer.full_name}
    expose(:license_number, if: {type: :default}) {|model| model.plate.try(:license_number)}
    expose(:phone_number, if: {type: :default}) {|model| model.store_customer.phone_number}
    expose :state, if: {type: :default} do |model|
      '施工中' if model.state == 'processing'
      '完工' if model.state == 'paying'
      '排队' if model.state == 'queuing'
      '草稿' if model.state == 'pending'
    end
    expose :task_status, if: {type: :default} do |model|
      '施工中' if model.task_status == 'task_processing'
      '完工' if model.task_status == 'task_finished'
      '排队' if model.task_status == 'task_queuing'
      '草稿' if model.task_status == 'task_pending'
    end

    expose :orderable_type, :orderable_id, :from_customer_asset, :discount,
           :discount_reason, :vip_price, :quantity, if: {type: :full}
    expose(:name, if: {type: :full}) {|model|model.orderable.name}
    expose(:speci, if: {type: :full}) {|model| model.orderable.speci if model.orderable_type == 'StoreMaterial'}
    expose(:price, if: {type: :full}) {|model|model.retail_price}
    expose(:standard_time, if: {type: :full}) {|model|model.orderable.try(:standard_time)}
  end
end
