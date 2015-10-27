class StoreCustomer < ActiveRecord::Base
  include BaseModel

end

# == Schema Information
#
# Table name: store_customers
#
#  id             :integer          not null, primary key
#  store_id       :integer          not null
#  store_chain_id :integer          not null
#  store_staff_id :integer          not null
#  first_name     :string(45)       not null
#  last_name      :string(45)       not null
#  full_name      :string(45)       not null
#  created_at     :datetime
#  updated_at     :datetime
#  phone_number   :string(45)
#
