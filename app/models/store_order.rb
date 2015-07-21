class StoreOrder < ActiveRecord::Base
  include BaseModel

end

# == Schema Information
#
# Table name: store_orders
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  amount         :decimal(12, 4)   default(0.0)
#  remark         :string(255)
#
