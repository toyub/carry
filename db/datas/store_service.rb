puts "Now creating StoreService..."

StoreService.delete_all
StoreServiceSnapshot.delete_all
StoreServiceWorkflowSnapshot.delete_all

# creating store service
StoreService.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  name: '途乐镀晶',
  code: 'tuledujing',
  retail_price: 40.0,
  bargain_price: 39.0,
  point: 200,
  store_service_workflows_attributes: [
    {
      store_chain_id: StoreChain.first.try(:id),
      store_staff_id: StoreStaff.first.try(:id),
      store_id: Store.first.id,
      standard_time: 20,
      buffering_time: 10,
      factor_time: 5,
      name: '清洗',
      store_workstation_ids: StoreWorkstation.where(name: ["清洗工位1", "清洗工位2"]).pluck(:id).join(",")
    },
    {
      store_chain_id: StoreChain.first.try(:id),
      store_staff_id: StoreStaff.first.try(:id),
      store_id: Store.first.id,
      standard_time: 30,
      buffering_time: 20,
      factor_time: 5,
      name: '镀晶',
      store_workstation_ids: StoreWorkstation.where(name: ["镀晶工位1", "镀晶工位2"]).pluck(:id).join(",")
    },
    {
      store_chain_id: StoreChain.first.try(:id),
      store_staff_id: StoreStaff.first.try(:id),
      store_id: Store.first.id,
      standard_time: 10,
      buffering_time: 5,
      factor_time: 5,
      name: '清洁',
      store_workstation_ids: StoreWorkstation.where(name: ["清洁工位1", "清洁工位2"]).pluck(:id).join(",")
    }
  ]
)


StoreService.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.id,
  name: '途乐精致洗车',
  code: 'tulexiche',
  retail_price: 30.0,
  bargain_price: 29.0,
  point: 100,
  store_service_workflows_attributes: [
    {
      store_chain_id: StoreChain.first.try(:id),
      store_staff_id: StoreStaff.first.try(:id),
      store_id: Store.first.id,
      standard_time: 20,
      buffering_time: 10,
      factor_time: 5,
      name: '清洗',
      store_workstation_ids: StoreWorkstation.where(name: ["清洗工位1", "清洗工位2"]).pluck(:id).join(",")
    },
    {
      store_chain_id: StoreChain.first.try(:id),
      store_staff_id: StoreStaff.first.try(:id),
      store_id: Store.first.id,
      standard_time: 10,
      buffering_time: 5,
      factor_time: 5,
      name: '清洁',
      store_workstation_ids: StoreWorkstation.where(name: ["清洁工位1", "清洁工位2"]).pluck(:id).join(",")
    }
  ]
)
