StoreGroup.delete_all
StoreGroupMember.delete_all
StoreStaff.where(job_type_id: 1).delete_all

s1 = StoreStaff.create(
  store_chain_id: StoreChain.first.try(:id),
  store_id: Store.first.try(:id),
  phone_number: '13409871234',
  login_name: '13409871234',
  first_name: 'xx',
  last_name: 'oo',
  job_type_id: 1
)

s2 = StoreStaff.create(
  store_chain_id: StoreChain.first.try(:id),
  store_id: Store.first.try(:id),
  phone_number: '13429871234',
  login_name: '13429871234',
  first_name: 'aa',
  last_name: 'bb',
  job_type_id: 1
)

g1 = StoreGroup.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.try(:id),
  name: '1组'
)
g1.store_group_members.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.try(:id),
  member_id: s1.id
)
g1.store_group_members.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.try(:id),
  member_id: s2.id
)

g2 = StoreGroup.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.try(:id),
  name: '2组'
)

g2.store_group_members.create(
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  store_id: Store.first.try(:id),
  member_id: s1.id
)
