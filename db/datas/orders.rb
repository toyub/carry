puts "Now creating StoreSubscribeOrder..."

StoreSubscribeOrder.delete_all

StoreSubscribeOrder.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  remark: "备注",
  store_customer: StoreCustomer.first,
  store_vehicle: StoreVehicle.first,
  subscribe_date: Time.now.end_of_month,
  order_type: :auto,
    state: :pending,
)
