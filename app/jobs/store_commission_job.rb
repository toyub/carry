class StoreCommissionJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StoreStaff.all.each do |staff|
      commission = staff.store_commissions.create!(commission_params(staff))
      order_items = (staff.store_order_items + staff.store.store_order_items.joins(:store_staff_tasks).where(store_staff_tasks: {store_staff_id: staff}).by_month(Time.now)).uniq! || []
      order_items.each do |item|
        staff.store_commission_items.create!(commission_item_params(staff, item, commission))
      end
    end
  end

  private
  def commission_params(staff)
    commission = ActionController::Parameters.new(
      store_id:           staff.store.id,
      store_chain_id:     staff.store_chain.id,
      store_staff_id:     staff.id,
      created_month:      Time.now.strftime("%Y%m")
    )
    commission.permit(:store_id, :store_chain_id, :store_staff_id, :created_month)
  end

  def commission_item_params(staff, item, commission)
    commission_item = ActionController::Parameters.new(
      store_id:                 staff.store.id,
      store_chain_id:           staff.store_chain.id,
      store_order_id:           item.store_order.id,
      store_staff_id:           staff.id,
      store_commission_id:      commission.id,
      store_order_numero:       item.store_order.numero,
      store_order_item_id:      item.id,
      store_order_item_name:    item.orderable.name,
      store_order_item_remark:  remark_detail(staff, item),
      item_amount:              item.amount,
      orderable_type:           item.orderable_type,
      commission_amount:        staff.commission_of(item),
      commission_type:          'sale',
      order_created_at:         item.store_order.created_at
    )
    commission_item.permit(:store_id, :store_chain_id, :store_staff_id, :store_order_id, :store_commission_id,
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
