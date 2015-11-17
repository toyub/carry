class StoreMaterialOrder < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material
  belongs_to :store_supplier

  belongs_to :store_material_inventory
  has_many :items, class_name: 'StoreMaterialOrderItem'
  has_many :payments, class_name: 'StoreMaterialOrderPayment'


  accepts_nested_attributes_for :items, :payments

  scope :pending, ->{where('store_material_orders.process = 0')}
  scope :suspense, ->{where('0 <= store_material_orders.process and store_material_orders.process < 100')}
  scope :finished, ->{where('store_material_orders.process = 100')}

  def balance
    self.amount - self.paid_amount
  end
end

# == Schema Information
#
# Table name: store_material_orders
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  store_supplier_id :integer          not null
#  numero            :string(45)
#  amount            :decimal(12, 4)   default(0.0)
#  quantity          :integer          default(0)
#  paid_amount       :decimal(10, 2)   default(0.0)
#  process           :integer          default(0), not null
#  remark            :string(255)
#  status            :integer          default(0)
#  paid_status       :integer          default(0)
#  received_status   :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#
