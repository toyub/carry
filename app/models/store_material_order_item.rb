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

  ##以下这些方法都要重构、优化。
  #商品的价格、存库量的变化要有记录。
  #商品跟仓库的关系是通过库存表维持的。
  #depot has many invetories
  #material has many invetories
  #depot has many materials through invetories
  #因此商品的价格、存库量就会存在店与库两套
  def latest_cost_price
    (self.store_material.cost_price.to_f * self.store_material.inventory.to_i + self.received_quantity*self.price)/(self.store_material.inventory+self.received_quantity)
  end

  def latest_depot_cost_price(inventory)
    (inventory.cost_price.to_f * inventory.quantity.to_i + self.received_quantity*self.price)/(inventory.quantity+self.received_quantity)
  end

  def put_in_depot!(depot_id, smr_id)
    inventory = self.store_material.store_material_inventories.find_or_initialize_by(store_depot_id: depot_id,
                                                                                store_id: self.store_id,
                                                                                store_chain_id: self.store_chain_id)
    if inventory.store_staff_id.blank?
      inventory.store_staff_id = self.store_staff_id
      inventory.save
    end

    smir=inventory.store_material_inventory_records.create(store_id: self.store_id,
                                                    store_chain_id: self.store_chain_id,
                                                    store_staff_id: self.store_staff_id,
                                                    store_depot_id: depot_id,
                                                    store_material_id: self.store_material_id,
                                                    store_material_order_id: self.store_material_order_id,
                                                    store_material_order_item_id: self.id,
                                                    store_material_receipt_id: smr_id,
                                                    quantity: self.received_quantity,
                                                    prior_quantity: inventory.quantity,
                                                    ordered_quantiry: self.quantity,
                                                    prior_cost_price: self.store_material.cost_price,
                                                    ordered_cost_price: self.price,
                                                    latest_cost_price: latest_depot_cost_price(inventory))
    StoreMaterialLog.create({
      store_id: self.store_id,
      store_chain_id: self.store_chain_id,
      store_staff_id: self.store_staff_id,
      store_material_id: self.store_material.id,
      log_type: 'MaterialInventory',
      prior_value: {
        inventory: self.store_material.inventory,
        cost_price: self.store_material.cost_price
      }.to_json,
      value: {
        inventory: self.store_material.inventory + self.received_quantity,
        cost_price: latest_cost_price
      }.to_json
    })
    inventory.quantity = inventory.quantity + self.received_quantity
    self.store_material.cost_price = latest_cost_price
    inventory.cost_price = smir.latest_cost_price
    inventory.save
    self.store_material.save
    self.save
  end
end
