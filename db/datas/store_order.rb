puts "Now creating StoreOrder..."

StoreOrder.delete_all
StoreServiceSnapshot.delete_all
StoreServiceWorkflowSnapshot.delete_all

# creating store order

StoreOrder.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  store_customer: StoreCustomer.first,
  store_vehicle: StoreVehicle.first,
  items_attributes: [
    { orderable: StoreMaterialSaleinfo.where(service_needed: true).first, price: 120, quantity: 2 },
    { orderable: StoreMaterialSaleinfo.where(service_needed: true).first, price: 120, quantity: 2 },
    { orderable: StorePackage.first, price: 130, quantity: 2 },
    { orderable: StorePackage.first, price: 140, quantity: 2 },
    { orderable: StoreService.first, price: 260, quantity: 2 },
    { orderable: StoreService.last, price: 100, quantity: 2 },
  ]
)
