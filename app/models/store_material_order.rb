class StoreMaterialOrder < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material
  belongs_to :store_supplier

  has_many :store_material_inventories
  has_many :items, class_name: 'StoreMaterialOrderItem'
  has_many :payments, class_name: 'StoreMaterialOrderPayment'


  accepts_nested_attributes_for :items, :payments

  scope :pending, ->{where('store_material_orders.process = 0')}
  scope :suspense, ->{where('0 < store_material_orders.process and store_material_orders.process < 100')}
  scope :finished, ->{where('store_material_orders.process = 100')}

  def balance
    self.amount - self.paid_amount
  end
end
