StoreVehicle.delete_all
StoreVehicleRegistrationPlate.delete_all
VehicleBrand.delete_all
VehicleModel.delete_all
VehicleSeries.delete_all

store_brand = VehicleBrand.create!(
  name: "宝马"
)

store_model = VehicleModel.create!(
  name: "宝马"
)

store_vehicle_registration_plates = StoreVehicleRegistrationPlate.create!(
  license_number: "浙A56789",
  creator: StoreStaff.first
)

store_series = VehicleSeries.create!(
  name: "宝马"
)

StoreVehicle.create!(
  store_staff_id: StoreStaff.first.try(:id),
  numero: "111101010",
  vehicle_brand: store_brand,
  vehicle_model: store_model,
  vehicle_series: store_series,
  store_customer: StoreCustomer.first
)

VehiclePlate.create!(
  store_vehicle_id: StoreVehicle.first.id,
  store_vehicle_registration_plate_id: store_vehicle_registration_plates.id

)
