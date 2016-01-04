puts "Now creating StoreVehicle..."

StoreVehicle.delete_all
StoreVehicleRegistrationPlate.delete_all

StoreVehicle.create(
  store_id: Store.first.try(:id),
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_customer: StoreCustomer.first,
  plates_attributes: [
    {
      store_id: Store.first.try(:id),
      store_chain_id: StoreChain.first.try(:id),
      store_staff_id: StoreStaff.first.try(:id),
      store_customer: StoreCustomer.first,
      license_number: '浙A12345'
    }
  ]
)
