class InventoryService
  def initialize(inventory, staff)
     @inventory = inventory
     @staff = staff
     @store_material = inventory.store_material
     @store_depot = inventory.store_depot
  end

  def income!(quantity, cost_price)
    @quantity  = quantity
    @cost_price = cost_price
    StoreMaterialIncome.create!  store_staff_id: @staff.id,
                                                        store_material_id: @store_material.id,
                                                        store_material_inventory_id: @inventory.id,
                                                        store_depot_id:  @store_depot.id,
                                                        openings: openings,
                                                        accruals: accruals,
                                                        closings: income_closings
  end

  def outgo!(quantity)
    @quantity  = quantity
    StoreMaterialOutgo.create!  store_staff_id: @staff.id,
                                                      store_material_id: @store_material.id,
                                                      store_material_inventory_id: @inventory.id,
                                                      store_depot_id:  @store_depot.id,
                                                      openings: openings,
                                                      accruals: accruals,
                                                      closings: outgo_closings
  end

  def openings
    {
        inventory_quantity: @inventory.quantity,
        inventory_cost_price: @inventory.cost_price,
        material_quantity: @store_material.inventory,
        material_cost_price: @store_material.cost_price
    }
  end

  def accruals
      {
        quantity: @quantity,
        material_cost_price: @store_material.cost_price,
        inventory_cost_price: @inventory.cost_price,
        cost_price: @cost_price
      }
  end

  def income_closings
    if @inventory.quantity <= 0
      inventory_cost_price = @cost_price
    else
      inventory_cost_price = (@inventory.quantity * @inventory.cost_price + @quantity * @cost_price)/(@inventory.quantity + @quantity)
    end

    if @store_material.inventory <= 0
      material_cost_price = @cost_price
    else
      material_cost_price = (@store_material.cost_price * @store_material.inventory + @cost_price * @quantity)/(@store_material.inventory + @quantity)
    end
    
    {
      inventory_quantity: @inventory.quantity + @quantity,
      inventory_cost_price: inventory_cost_price,
      material_quantity: @store_material.inventory + @quantity,
      material_cost_price: material_cost_price
    }
  end

  def outgo_closings
    {
      inventory_quantity: @inventory.quantity - @quantity,
      inventory_cost_price: @inventory.cost_price,
      material_quantity: @store_material.inventory - @quantity,
      material_cost_price: @store_material.cost_price
     }
  end
end