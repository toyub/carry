class CheckMonthCommission
  def initialize(month = nil)
    @month = month || last_month
  end

  def run
    StoreOrderItem.by_month(@month).each do |item|
      if item.orderable.saleman_commission_template.present?
        make_sale_commission(item)
      end

      item.store_staff_tasks.each do |task|
        if task.constructed_commission_template.present?
          make_constructe_commission(task)
        end
      end
    end
  end


  private
  def make_sale_commission(item)
    staff = item.store_staff
    if item.orderable.saleman_commission_template.present?
      if item.orderable.saleman_commission_template.confined_to == CommissionConfineType::TYPES_ID['班组']
        commission = staff.store_department.store_commissions.find_or_create_by(commission_params(staff))
        staff.store_department.store_commission_items.create!(sale_commission_item_params(staff, item, commission, "卖出#{item.quantity}件"))
      else
        commission = staff.store_commissions.find_or_create_by(commission_params(staff))
        staff.store_commission_items.create!(sale_commission_item_params(staff, item, commission, "卖出#{item.quantity}件"))
      end
    end
  end

  def make_constructe_commission(task)
    staff = task.store_staff
    item = task.store_order_item
    if task.constructed_commission_template.present?
      if task.constructed_commission_template.confined_to == CommissionConfineType::TYPES_ID['班组']
        commission = staff.store_department.store_commissions.find_or_create_by(commission_params(staff))
        staff.store_department.store_commission_items.create!(task_commission_item_params(staff, task, item, commission, task.workflow_snapshot.name))
      else
        commission = staff.store_commissions.find_or_create_by(commission_params(staff))
        staff.store_commission_items.create!(task_commission_item_params(staff, task, item, commission, task.workflow_snapshot.name))
      end
    end
  end

  def commission_params(staff)
    commission = ActionController::Parameters.new(
      store_id:           staff.store.id,
      store_chain_id:     staff.store_chain.id,
      created_month:      @month.strftime("%Y%m")
    )
    commission.permit(:store_id, :store_chain_id, :created_month)
  end

  def sale_commission_item_params(staff, item, commission, remark)
    commission_item = ActionController::Parameters.new(
      store_id:                 staff.store.id,
      store_chain_id:           staff.store_chain.id,
      store_order_id:           item.store_order.id,
      store_staff_id:           staff.id,
      store_commission_id:      commission.id,
      store_order_numero:       item.store_order.numero,
      store_order_item_id:      item.id,
      store_order_item_name:    item.orderable.name,
      store_order_item_remark:  remark,
      item_amount:              item.amount,
      orderable_type:           item.orderable_type,
      commission_amount:        staff.sale_commission_of(item),
      commission_type:          check_commission_type(staff, item),
      order_created_at:         item.store_order.created_at
    )
    commission_item.permit(:store_id, :store_chain_id, :store_staff_id, :store_order_id, :store_commission_id,
                           :store_order_numero, :store_order_item_id, :store_order_item_name,
                           :store_order_item_remark, :item_amount, :orderable_type, :commission_amount,
                           :commission_type, :order_created_at)
  end

  def task_commission_item_params(staff, task, item, commission, remark)
    commission_item = ActionController::Parameters.new(
      store_id:                 staff.store.id,
      store_chain_id:           staff.store_chain.id,
      store_order_id:           item.store_order.id,
      store_staff_id:           staff.id,
      store_commission_id:      commission.id,
      store_order_numero:       item.store_order.numero,
      store_order_item_id:      item.id,
      store_order_item_name:    item.orderable.name,
      store_order_item_remark:  remark,
      item_amount:              item.amount,
      orderable_type:           item.orderable_type,
      commission_amount:        staff.task_commission_of(task),
      commission_type:          check_commission_type(staff, item),
      order_created_at:         item.store_order.created_at
    )
    commission_item.permit(:store_id, :store_chain_id, :store_staff_id, :store_order_id, :store_commission_id,
                           :store_order_numero, :store_order_item_id, :store_order_item_name,
                           :store_order_item_remark, :item_amount, :orderable_type, :commission_amount,
                           :commission_type, :order_created_at)
  end

  def check_commission_type(staff, item)
    type = 'sale'
    type = 'constructed' if item.constructed_by? staff
    type = 'all' if item.saled_by?(staff) && item.constructed_by?(staff)
    type
  end

  def last_month
    Time.now.last_month
  end
end
