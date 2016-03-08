class StoreCommissionItemJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StoreOrder.all.each do |order|
      order.items.each do |item|
        item.store_staff.store_commission_items.create!(commission_params(item.store_staff, item, 'sale'))
        StoreStaff.joins(:store_staff_tasks).where(store_staff_tasks: {store_order_item_id: item}).each do |staff|
          staff.store_commission_items.create!(commission_params(staff, item, 'constructed'))
        end
      end
    end
  end

  private
  def commission_params(staff, item, commission_type)
    commission = ActionController::Parameters.new(
      store_id:                 staff.store.id,
      store_chain_id:           staff.store_chain.id,
      store_order_id:           item.store_order.id,
      store_staff_id:           staff.id,
      store_order_numero:       item.store_order.numero,
      store_order_item_id:      item.id,
      store_order_item_name:    item.orderable.name,
      store_order_item_remark:  remark_detail(staff, item),
      item_amount:              item.amount,
      orderable_type:           item.orderable_type,
      commission_amount:        staff.commission_of(item),
      commission_type:          commission_type,
      order_created_at:         item.store_order.created_at
    )
    commission.permit(:store_id, :store_chain_id, :store_staff_id, :store_order_id,
                        :store_order_numero, :store_order_item_id, :store_order_item_name,
                        :store_order_item_remark, :item_amount, :orderable_type, :commission_amount,
                        :commission_type, :order_created_at)
  end

  def remark_detail(staff, item)
    remark = ""
    remark += "卖出#{item.quantity}件" if item.saled_by? staff
    if item.constructed_by? staff
      staff.store_staff_tasks.by_item(item).each do |task|
        remark += task.workflow_snapshot.try(:name)
        remark += task.commission.to_s
        remark += " "
      end
    end
    remark
  end

end
