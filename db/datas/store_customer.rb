puts "Now creating StoreCustomer..."

StoreCustomerEntity.delete_all
StoreCustomer.delete_all

StoreCustomerEntity.create(
  store: Store.first,
  store_chain: StoreChain.first,
  store_staff_id: StoreStaff.first.id,
  store_customer_attributes: {
    store_id: Store.first.try(:id),
    store_chain_id: StoreChain.first.try(:id),
    store_staff_id: StoreStaff.first.id,
    first_name: "我是",
    last_name: "测试",
    phone_number: "15000002923"
  },
  store_customer_settlement_attributes: {
    store_id: Store.first.try(:id),
    store_chain_id: StoreChain.first.try(:id),
    store_staff_id: StoreStaff.first.id,
    payment_mode: 'cash'
  }
)
