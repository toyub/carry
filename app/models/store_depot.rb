class StoreDepot  < ActiveRecord::Base
  include BaseModel
  has_many :store_material_inventories

  default_scope {where(deleted: false).order('id asc')}

  scope :preferred, ->{where(preferred: true)}

  def material_types_count
    self.store_material_inventories.count(:id)
  end
  
  def toggle_useable!
    self.update!(useable: !self.useable)
  end

  def self.current_preferred
    self.where(preferred: true).first
  end

  def binding_material_count
    self.store_material_inventories.where('quantity > 0').count(:id)
  end

  def outing_order_materials!(order)
    store_id = self.store_id
    store_chain_id = self.store_chain_id
    store_staff_id = self.store_staff_id

    outing = StoreMaterialOuting.create!(store_id: store_id,
                                                                 store_chain_id: store_chain_id,
                                                                 store_staff_id: self.store_staff_id,
                                                                 requester_id: order.store_staff_id,
                                                                 outing_type_id: OutingType.find_by_name('销售出库').id,
                                                                 outingable: order)
    order.items.materials.each do |order_item|
      material = order_item.orderable.store_material
      next if order_item.orderable.divide_to_retail
      inventory = self.store_material_inventories
                                .find_or_initialize_by(store_id: store_id,
                                                                    store_chain_id: store_chain_id,
                                                                    store_material_id: material.id)
      if inventory.new_record?
        inventory.store_staff_id = store_staff_id
        inventory.cost_price = material.cost_price
        inventory.save
      end

      items_attributes = {
        outing_type_id: OutingType.find_by_name('销售出库').id,
        store_id: store_id,
        store_chain_id: store_chain_id,
        store_staff_id: self.store_staff_id,
        requester_id: order.store_staff_id,
        store_material_id: material.id,
        store_material_inventory_id: inventory.id,
        store_depot_id: self.id,
        quantity: order_item.quantity,
        cost_price: material.cost_price.to_f,
        inventory_cost_price: inventory.cost_price
      }

      outing.items << StoreMaterialOutingItem.new(items_attributes)
      @log = InventoryService.new(inventory, order.creator).outgo!(order_item.quantity).loggable!(order_item)
      inventory.outing!(order_item.quantity)
    end
    outing.total_quantity = outing.items.sum(:quantity)
    outing.total_amount = outing.items.sum(:amount)
    outing.save!
  end
end
