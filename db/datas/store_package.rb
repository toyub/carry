puts "Now creating StorePackage..."

StorePackage.delete_all
StorePackageItem.delete_all
StoreDepositCard.delete_all

# creating store package
package = StorePackage.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  name: "充100送120",
  price: 100
)

StoreDepositCard.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  name: "充100送120",
  price: 100,
  denomination: 120
)

package.package_setting.update(
  items_attributes: [
    { package_itemable: StoreMaterial.first, price: 100, quantity: 1 },
    { package_itemable: StoreService.first, price: 100, quantity: 1 },
    { package_itemable: StoreDepositCard.first, price: 100, quantity: 10 }
  ]
)
