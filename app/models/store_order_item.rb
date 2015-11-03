class StoreOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :orderable, polymorphic: true
  belongs_to :store_order
  belongs_to :store_customer
end
<<<<<<< HEAD

# == Schema Information
#
# Table name: store_order_items
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  quantity          :integer          default(0)
#  price             :decimal(10, 4)   default(0.0)
#  amount            :decimal(12, 4)   default(0.0)
#  remark            :string(255)
#  orderable_id      :integer          not null
#  orderable_type    :string(60)       not null
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  store_order_id    :integer
#  store_customer_id :integer
#
# Indexes
#
#  orderable  (orderable_id)
#
=======
>>>>>>> development
