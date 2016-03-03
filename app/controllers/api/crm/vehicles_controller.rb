module Api
  module Crm
    class VehiclesController < Api::BaseController
      def index
      end

      def update
        vehicle = current_store.store_vehicles.find(params[:id])
        safe_params = append_store_attrs(vehicle_params)
        safe_params[:detail] = vehicle.detail.deep_merge(safe_params[:detail])
        if vehicle.update(safe_params)
          render json: StoreVehicleSerializer.new(vehicle).to_json(root: nil)
        else
          respond_with vehicle, location: nil
        end
      end

      private
      def vehicle_params
        params.require(:vehicle).permit :vehicle_brand_id,
                                              :vehicle_series_id,
                                              :vehicle_model_id,
                                              detail: [
                                                       :numero,
                                                       :organization_type,
                                                       :bought_on,
                                                       :ex_factory_date,
                                                       :maintained_at,
                                                       :maintained_mileage,
                                                       :maintain_interval_time,
                                                       :maintain_interval_mileage,
                                                       :next_maintain_mileage,
                                                       :next_maintain_at,
                                                       :color,
                                                       :capacity,
                                                       :registered_on,
                                                       :mileage,
                                                       :annual_check_at,
                                                       :insurance_compnay,
                                                       :insurance_expire_at,
                                                       :next_maintain_customer_alermify,
                                                       :next_maintain_store_alermify,
                                                       :annual_check_customer_alermify,
                                                       :annual_check_store_alermify,
                                                       :insurance_customer_alermify,
                                                       :insurance_store_alermify
                                                     ],
                                              frame_attributes: [:vin],
                                              plates_attributes: [:license_number],
                                              engines_attributes: [:identification_number]
      end
    end
  end
end
