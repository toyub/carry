puts "Now creating StoreSubscribeOrder..."

StoreSubscribeOrder.delete_all

StoreSubscribeOrder.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  remark: "要是忘记了，请提醒下我，谢谢",
  store_customer: StoreCustomer.first,
  store_vehicle: StoreVehicle.first,
  subscribe_date: Time.now.end_of_month,
  order_type: :auto,
    state: :pending,
)