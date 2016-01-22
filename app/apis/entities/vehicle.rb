module Entities
  class Vehicle < Grape::Entity
    expose :basic_info do
      expose :id
      expose :license_number
      expose :identification_number
      expose :vin
      expose(:vehicle_brand){ |vehicle, options| vehicle.vehicle_brand.name }
      expose(:vehicle_model){ |vehicle, options| vehicle.vehicle_model.name }
      expose(:vehicle_series){ |vehicle, options| vehicle.vehicle_series.name }
      expose :operator
      expose(:created_at){ |vehicle, options| vehicle.created_at.strftime('%Y-%m-%d') }
      expose :color
      expose :capacity
      expose :organization_type
      expose :bought_on
      expose :ex_factory_date
      expose :registered_on
      expose :mileage
    end

    expose :detail do
      expose(:numero){ |vehicle, options| vehicle.detail_by('numero') }
      expose :maintained_at
      expose :maintained_mileage
      expose :maintain_interval_time
      expose :maintain_interval_mileage
      expose :next_maintain_mileage
      expose :next_maintain_at
      expose :annual_check_at
      expose :insurance_compnay
      expose :insurance_expire_at
      expose :next_maintain_customer_alermify
      expose :next_maintain_store_alermify
      expose :annual_check_customer_alermify
      expose :annual_check_store_alermify
      expose :insurance_customer_alermify
    end

    expose :damages

    expose :orders, using: ::Entities::Order

    private

      def damages
        object.orders.order('created_at desc').map do |order|
          order.situation.fetch('damages', []).map do |damage|
            {
              created_at: order.created_at.strftime('%Y-%m-%d'),
              content: damage['content']
            }
          end
        end.flatten!
      end

  end
end
