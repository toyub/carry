class StoreStaffCommissionHistoryJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StoreStaff.all.each do |staff|
      staff.store_order_items.by_month.each do |item|
        staff.commission_hiseories.create!(commission_params(staff, item))
      end
    end
  end

  private
  def commission_params(staff, item)
    commission = ActionController::Parameters.new(
      store_id: staff.store.id,
      store_chain_id:     staff.store_chain.id,
      store_order_id: item.store_order.id,
      store_order_numero: item.store_order.numero,
      store_order_item_id: item.id,
      store_order_item_name: item.orderable.name,
      store_order_item_remark: remark_detail(staff, item),
      item_amount: item.amount,
      commission_amount: staff.commission_of(item),
      commission_type: commission_type(staff, item),
      order_created_at: item.store_order.created_at
    )
    commission.permit(:store_id, :store_chain_id, :store_staff_id, :store_order_id,
                        :store_order_numero, :store_order_item_id, :store_order_item_name,
                        :store_order_item_remark, :item_amount, :commission_amount,
                        :commission_type, :order_created_at)
  end

  def commission_type(staff, item)
    type = 'sale'
    type = 'constructed' if item.constructed_by? staff
    type = 'all' if item.constructed_by?(staff) && item.constructed_by?(staff)
    type
  end

  def remark_detail(staff, item)
    remark = ""
    remark += "卖出#{item.quantity}件" if item.saled_by? staff
    if item.constructed_by? staff
      staff.tasks.by_item(item).each do |task|
        remark += task.workflow_snapshot.try(:name)
        remark += task.commission.to_s
        remark += " "
      end
    end
    remark
  end

end
