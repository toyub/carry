class VehicleEngine < ActiveRecord::Base
  belongs_to :store_vehicle
  belongs_to :engine, class_name: 'StoreVehicleEngine', foreign_key: :store_vehicle_engine_id
end
