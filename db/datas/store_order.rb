puts "Now creating StoreOrder..."

StoreOrder.delete_all

# creating store package
StorePackage.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  name: "充100送120",
  price: 100
)

StoreOrder.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  store_customer: StoreCustomer.first,
  store_vehicle: StoreVehicle.first,
  items_attributes: [
    { orderable: StoreMaterialSaleinfo.first, price: 100, quantity: 10 },
    { orderable: StoreMaterialSaleinfo.first, price: 120, quantity: 20 },
    { orderable: StorePackage.first, price: 130, quantity: 30 },
    { orderable: StorePackage.first, price: 140, quantity: 30 },
  ]
)
