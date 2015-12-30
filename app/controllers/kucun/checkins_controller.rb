#Just In Time
class Kucun::CheckinsController < Kucun::BaseController
  def index
    @items = StoreMaterialCheckinItem.where(store_id: current_store.id)
  end

  def new
    @store = current_store
  end

  def create
    @checkin = StoreMaterialCheckin.new(checkin_params)
    ActiveRecord::Base.transaction do
      @checkin.store_staff_id = current_user.id
      @checkin.quantity = 0
      @checkin.amount = 0
      @checkin.items.each do |item|
        item.store_depot_id = @checkin.store_depot_id
        item.store_staff_id = @checkin.store_staff_id
        item.amount = item.quantity * item.price
        @checkin.quantity += item.quantity
        @checkin.amount += item.amount


        inventory = StoreMaterialInventory.find_or_initialize_by(store_depot_id: item.store_depot_id,
                                                                 store_material_id: item.store_material_id)
        if inventory.store_staff_id.blank?
          inventory.store_staff_id = item.store_staff_id
          inventory.save
        end

        item.prior_quantity = inventory.quantity
        item.prior_cost_price = inventory.cost_price
        item.store_material_inventory_id = inventory.id
        StoreMaterialLog.create({
          store_staff_id: item.store_staff_id,
          store_material_id: inventory.store_material.id,
          log_type: 'MaterialInventory',
          prior_value: {
            inventory: inventory.store_material.inventory,
            cost_price: inventory.store_material.cost_price
          }.to_json,
          value: {
            inventory: inventory.store_material.inventory + item.quantity,
            cost_price: latest_cost_price(inventory.store_material, item)
          }.to_json
        })

        inventory.cost_price = latest_depot_cost_price(inventory, item)
        inventory.store_material.cost_price = latest_cost_price(inventory.store_material, item)
        inventory.quantity = inventory.quantity + item.quantity
        inventory.save!
        inventory.store_material.save!
        item.latest_cost_price = inventory.store_material.cost_price
      end
      @checkin.save!
    end
    
    redirect_to action: 'index'
  end

  private
  def checkin_params
    params.require(:store_material_order).permit(:remark, :store_depot_id,
                                                 items_attributes: [:store_material_id,:price,:quantity,:remark])
  end

  def latest_depot_cost_price(inventory, item)
    (inventory.cost_price * inventory.quantity + item.cost_price * item.quantity)/(inventory.quantity+item.quantity)
  end

  def latest_cost_price(material, item)
    puts "\n"*8
    p item
    puts
    puts "\n"*8
    a = material.inventory.to_i * material.cost_price
    b = item.price * item.quantity
    (a + b)/(material.inventory + item.quantity)
  end

end
