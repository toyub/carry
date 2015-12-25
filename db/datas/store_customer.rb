puts "Now creating StoreCustomer..."

StoreCustomer.delete_all

store_customer = StoreCustomer.new(
  store_id: Store.first.try(:id),
  store_chain_id: StoreChain.first.try(:id),
  store_staff_id: StoreStaff.first.try(:id),
  first_name: "我是",
  last_name: "测试",
  phone_number: "15000002923",

)

if store_customer.save
  puts "#{store_customer.full_name} 创建成功"
else
  puts "#{store_customer.errors}"
end
