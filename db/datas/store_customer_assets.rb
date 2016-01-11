puts "Now creating StoreCustomerAssets..."

StoreCustomerAsset.delete_all
StoreCustomerAssetItem.delete_all

# creating store asset item

order_archive = StoreOrderArchive.new(nil, StoreOrder.first)
order_archive.save_deposit_cards
order_archive.save_package_services
order_archive.save_taozhuang
