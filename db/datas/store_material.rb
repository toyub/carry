StoreMaterial.delete_all
StoreMaterialSaleinfo.delete_all

StoreMaterial.create([
  {
    name: "商品1",
    speci: "规格",
    store: Store.first,
    store_chain: StoreChain.first,
    store_staff_id: StoreStaff.first.id,
    store_material_root_category_id: StoreMaterialCategory.first.id,
    store_material_category_id: StoreMaterialCategory.first.id,
    store_material_unit_id: StoreMaterialUnit.first.id,
    store_material_manufacturer_id: StoreMaterialManufacturer.first.id,
    store_material_brand_id: StoreMaterialBrand.first.id
  },
  {
    name: "商品2",
    speci: "规格2",
    store: Store.first,
    store_chain: StoreChain.first,
    store_staff_id: StoreStaff.first.id,
    store_material_root_category_id: StoreMaterialCategory.first.id,
    store_material_category_id: StoreMaterialCategory.first.id,
    store_material_unit_id: StoreMaterialUnit.first.id,
    store_material_manufacturer_id: StoreMaterialManufacturer.first.id,
    store_material_brand_id: StoreMaterialBrand.first.id
  }
])

StoreMaterialSaleinfo.create(
  store: Store.first,
  store_chain: StoreChain.first,
  store_staff_id: StoreStaff.first.id,
  store_material: StoreMaterial.first
)

StoreMaterialSaleinfo.create(
  store: Store.first,
  store_chain: StoreChain.first,
  store_staff_id: StoreStaff.first.id,
  store_material: StoreMaterial.last
)
