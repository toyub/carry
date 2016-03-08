class Kucun::MaterialInventoriesController < Kucun::BaseController
  def index
    @record_items = StoreMaterialInventoryRecord.where(store_id: current_store.id)
  end

  def new
    @store = current_user.store
    @store_material_orders = @store.store_material_orders.suspense.all
  end

  def create
    store = current_user.store
    order = store.store_material_orders.suspense.find(params[:order_id])
    ActiveRecord::Base.transaction do

      smr = StoreMaterialPurchaseReceipt.create(store_staff_id: current_user.id, remark: params[:remark], source_order: order)
      order.items.where(id: params[:items].keys).each do |item|
        item_params = params[:items][item.id.to_s]
        if item.quantity == item_params[:received_quantity].to_f
          item.all_receive
        elsif item.quantity < item_params[:received_quantity].to_f
          item.excess_receive(item_params[:received_quantity].to_f)
        else
          item.partially_receive(item_params[:received_quantity].to_f)
        end
        put_in_depot!(item, item_params[:store_depot_id], smr.id, item_params[:remark])
      end
      order.process = order.items.sum(:process)/order.items.length
      order.save!
      smr.save!
    end
    redirect_to action: :new
  end


  private
  def put_in_depot!(item, depot_id, smr_id, remark)
    inventory = item.store_material
                                 .store_material_inventories
                                 .find_or_initialize_by(store_depot_id: depot_id)
    if inventory.store_staff_id.blank?
      inventory.store_staff_id = current_user.id
      inventory.save
    end

    @log = InventoryService.new(inventory, current_user).income!(item.received_quantity, item.price)

    smir=inventory
              .store_material_inventory_records.create!(store_id: item.store_id,
                                                    store_chain_id: item.store_chain_id,
                                                    store_staff_id: item.store_staff_id,
                                                    store_depot_id: depot_id,
                                                    store_material_id: item.store_material_id,
                                                    store_material_order_id: item.store_material_order_id,
                                                    store_material_order_item_id: item.id,
                                                    store_material_receipt_id: smr_id,
                                                    quantity: item.received_quantity,
                                                    prior_quantity: inventory.quantity,
                                                    ordered_quantiry: item.quantity,
                                                    prior_cost_price: item.store_material.cost_price,
                                                    ordered_cost_price: item.price,
                                                    latest_cost_price:  @log.closings.symbolize_keys[:inventory_cost_price],
                                                    remark: remark)

    @log.loggable!(smir)
    inventory.quantity = @log.closings.symbolize_keys[:inventory_quantity]
    item.store_material.cost_price = @log.closings.symbolize_keys[:material_cost_price]
    inventory.cost_price = smir.latest_cost_price
    inventory.save!
    item.store_material.save!
    item.save!
  end
end
