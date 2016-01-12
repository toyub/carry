puts "Now creating StoreCustomerAssets..."

StoreCustomerAsset.delete_all
StoreCustomerAssetItem.delete_all
StoreCustomerAssetLog.delete_all

# creating store asset item

order_archive = StoreOrderArchive.new(nil, StoreOrder.first)
order_archive.save_deposit_cards
order_archive.save_package_services
order_archive.save_taozhuang

# creating store customer asset logs

StoreCustomerAssetLog.create(
  store_chain_id: StoreChain.first.try(:id),
  store_id: Store.first.id,
  store_customer_id: StoreCustomer.first.try(:id),
  store_vehicle_id: StoreVehicle.first.try(:id),
  store_order_id: StoreOrder.first.try(:id),
  store_order_item_id: StoreOrder.first.items.packages.first,
  store_customer_asset_item_id: StoreCustomerPackagedService.first.items.first.try(:id),
  latest: 20,
  quantity: 10,
  balance: 10
)

StoreCustomerAssetLog.create(
  store_chain_id: StoreChain.first.try(:id),
  store_id: Store.first.id,
  store_customer_id: StoreCustomer.first.try(:id),
  store_vehicle_id: StoreVehicle.first.try(:id),
  store_order_id: StoreOrder.first.try(:id),
  store_order_item_id: StoreOrder.first.items.materials.first,
  store_customer_asset_item_id: StoreCustomerTaozhuang.first.items.first.try(:id),
  latest: 20,
  quantity: 10,
  balance: 10
)
