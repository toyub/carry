class StoreMaterialOrderItem < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material_order

  attr_accessor :checked
  scope :pending, ->{where('store_material_order_items.process = 0')}
  scope :suspense, ->{where('0 <= store_material_order_items.process and store_material_order_items.process < 100')}
  scope :finished, ->{where('store_material_order_items.process = 100')}

  def left_quantity
    self.quantity - (self.received_quantity + self.returned_quantity)
  end

  def all_return!
    self.received_quantity = 0
    self.returned_quantity = self.quantity
    self.process = 100
    self.save
  end

  def all_receive
    self.received_quantity = self.quantity
    self.returned_quantity = 0
    self.process = 100
  end

  def excess_receive(received_quantity)
    self.received_quantity = self.received_quantity
    self.returned_quantity = 0
    self.process = 100
  end

  def partially_receive(received_quantity)
    self.received_quantity = received_quantity
    self.returned_quantity = 0
    self.process = (((self.received_quantity + self.returned_quantity)/self.quantity.to_f) * 100).to_i
  end
end
