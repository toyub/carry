class StoreMaterialOrderItem < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material_order

  attr_accessor :checked
  scope :pending, ->{where('store_material_order_items.process = 0')}
  scope :suspense, ->{where('0 < store_material_order_items.process and store_material_order_items.process < 100')}
  scope :finished, ->{where('store_material_order_items.process = 100')}

  def all_return!
    self.received_quantity = 0
    self.returned_quantity = self.quantity
    self.process = (((self.received_quantity + self.returned_quantity)/self.quantity.to_f) * 100).to_i
    self.save
  end

  def all_receive
    self.received_quantity = self.quantity
    self.returned_quantity = 0
  end

  def all_receive_and_reorder_excess(received_quantity)
    excess_quantity = received_quantity - self.quantity
    self.received_quantity = self.quantity
    self.returned_quantity = 0

    item = self.class.new({
                store_id: self.store_id,
                store_chain_id: self.store_chain_id,
                store_staff_id: self.store_staff_id,
                store_material_id: self.store_material_id,
                store_supplier_id: self.store_supplier_id,
                quantity: excess_quantity,
                price: self.price,
                amount: self.price * excess_quantity
              })

    return item
  end

  def partially_receive(received_quantity)
    self.received_quantity = received_quantity
    self.returned_quantity = 0
  end

  def put_in_depot!(depot_id)
    inventory = self.store_material.store_material_inventories.find_or_initialize_by(store_depot_id: depot_id,
                                                                                store_id: self.store_id,
                                                                                store_chain_id: self.store_chain_id)
    if inventory.store_staff_id.blank?
      inventory.store_staff_id = self.store_staff_id
      inventory.save
    end

    latest_cost_price=(self.store_material.cost_price * self.store_material.inventory + self.received_quantity*self.price)/(self.store_material.inventory+self.received_quantity)
    inventory.store_material_inventory_records.create(store_id: self.store_id,
                                                    store_chain_id: self.store_chain_id,
                                                    store_staff_id: self.store_staff_id,
                                                    store_depot_id: depot_id,
                                                    store_material_id: self.store_material_id,
                                                    store_material_order_id: self.store_material_order_id,
                                                    store_material_order_item_id: self.id,
                                                    quantity: self.received_quantity,
                                                    prior_quantity: inventory.quantity,
                                                    ordered_quantiry: self.quantity,
                                                    prior_cost_price: self.store_material.cost_price,
                                                    ordered_cost_price: self.price,
                                                    latest_cost_price: latest_cost_price)

    inventory.quantity = inventory.quantity + self.received_quantity
    self.store_material.cost_price = latest_cost_price
    inventory.save
    self.store_material.save
    self.process = (((self.received_quantity + self.returned_quantity)/self.quantity.to_f) * 100).to_i
    self.save
  end
end
