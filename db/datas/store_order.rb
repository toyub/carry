puts "Now creating StoreOrder..."

StoreOrder.delete_all

StoreOrder.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id
)
