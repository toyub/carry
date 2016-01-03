puts "Now creating StoreWorkstation..."

StoreWorkstation.delete_all

# creating store workstation
["清洗工位1", "清洗工位2", "镀晶工位1", "镀晶工位2", "清洁工位1", "清洁工位2"].each do |name|
  StoreWorkstation.create(
    store_chain_id: StoreChain.first.try(:id),
    store_staff_id: StoreStaff.first.try(:id),
    store_id: Store.first.id,
    name: name
  )
end
