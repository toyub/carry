# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ActiveRecord::Base.transaction do
  ## 门店信息
  chain = StoreChain.create!
  store = Store.create!(name: '门店', store_chain: chain)
  admin = StoreStaff.create! store: store, store_chain: chain, phone_number: "13356568989",
                            login_name: '13356568989', first_name: 'issac', last_name: 'lau',
                            password: '88888888', password_confirmation: "88888888"

  store.update!(admin_id: admin.id)
  chain.update!(admin_id: admin.id, head_office: store)


  ## 职员信息
  engineer_li = StoreStaff.create!(store: store, store_chain: chain, login_name: "1331234567", phone_number: '1331234567', last_name: '李', first_name: '丰')
  engineer_wang = StoreStaff.create!(store: store, store_chain: chain, login_name: "1331234568", phone_number: '1331234568', last_name: '王', first_name: '洋洋')


  ## 商品信息
  unit = StoreMaterialUnit.create!(name: "个", store: store, store_chain: chain, store_staff_id: admin.id)
  brand = StoreMaterialBrand.create!(name: "斯诺比", store: store, store_chain: chain, creator: admin)
  category = StoreMaterialCategory.create!(name: "消费", store: store, store_chain: chain, store_staff_id: admin.id)
  manufacturer = StoreMaterialManufacturer.create!(name: "制造商", store: store, creator: admin)
  material = StoreMaterial.create!(name: "米其林", store: store, store_chain: chain, store_staff_id: admin.id, store_material_unit: unit, store_material_manufacturer: manufacturer, store_material_brand: brand, store_material_category: category, store_material_root_category: category)


  ## 服务信息
  service_category = StoreServiceCategory.create!(name: "服务类别", store: store, creator: admin)
  store_service = StoreService.create!(name: '澜泰纳米镀晶', store: store, creator: admin, store_service_category: service_category, code: "xxxxx")
  workflow1 = store_service.store_service_workflows.create!(name: '镀晶', store_id: store.id, store_chain_id: chain.id, store_staff_id: admin.id)
  workflow2 = store_service.store_service_workflows.create!(name: '抛光', store_id: store.id, store_chain_id: chain.id, store_staff_id: admin.id)
  workstation1 = StoreWorkstation.create!(name: "1号工位", store: store, creator: admin)
  workstation2 = StoreWorkstation.create!(name: "2号工位", store: store, creator: admin)


  ## 客户信息
  customer = StoreCustomer.create!(store: store, creator: admin, first_name: '靖', last_name: "郭", full_name: "郭靖", phone_number: "15000002923")


  ## vehicle_nav
  car_brand = StoreVehicleBrand.create!(store: store, creator: admin, name: "宝马")
  car = StoreVehicle.create!(store: store, creator: admin, model: "宝马5系", series: "宝马新5系", brand: car_brand)
  car.create_engine!(store: store, creator: admin, identification_number: "88971285987612")
  car.create_frame!(store: store, creator: admin, vin: "88971285987612")
  car.create_registration_plate!(store_customer: customer, store: store, creator: admin, license_number: "88971285987612")

  ## 订单信息
  store_service_snapshot = store_service.snapshots.create!(store_service.attributes)
  workflow1.snapshots.create!(workflow1.attributes.merge(store_service: store_service_snapshot, store_workstation: workstation1, store_engineer_ids: engineer_li.id))
  workflow2.snapshots.create!(workflow2.attributes.merge(store_service: store_service_snapshot, store_workstation: workstation2, store_engineer_ids: engineer_wang.id))
  material_snapshot = material.snapshots.create!(material.attributes)

  order = StoreOrder.create!(store_customer: customer, store: store, creator: admin, amount: 1000.00)
  store_service_snapshot.create_store_order_item!(store_customer: customer, store: store, creator: admin, store_order: order, quantity: 1, price: 500, amount: 500)
  material_snapshot.create_store_order_item!(store_customer: customer, store: store, creator: admin, store_order: order, quantity: 1, price: 500, amount: 500)

end
