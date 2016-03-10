class ConstructPerformance
  def initialize(staffs, month)
    @staffs = staffs
    @month = month
    @performances = []
    set_performance_data
  end

  def performances
    @performances
  end

  private
  def set_performance_data
    @staffs.each do |staff|
      next unless staff.store_commissions.find_by(created_month: @month.strftime("%Y%m")).present? || staff.has_commission?(@month)
      basic_info = {
        id: staff.id,
        name: staff.screen_name,
        numero: staff.numero,
        department: staff.store_department.try(:name),
        position: staff.store_position.try(:name),
      }
      if commission_history = staff.store_commissions.find_by(created_month: @month.strftime("%Y%m"))
        commission_info = {
          order_quantity:     commission_history.store_commission_items.select(:store_order_id).uniq.count,
          sale_quantity:      commission_history.store_commission_items.by_type('sale').count,
          sale_amount:        commission_history.store_commission_items.by_type('sale').map(&:item_amount).sum,
          task_quantity:      commission_history.store_commission_items.by_type('constructed').count,
          task_amount:        commission_history.store_commission_items.by_type('sale').map(&:item_amount).sum,
          trade_amount:       commission_history.store_commission_items.by_type('sale').map(&:item_amount).sum,
          commission_amount:  commission_history.store_commission_items.map(&:commission_amount).sum,
        }
      else
        case staff.job_type_id
        when JobType::TYPES_ID['技师']
          commission_info = {
            order_quantity:            (staff.store_orders.by_month(@month).pluck(:id) + staff.store_staff_tasks.joins(:store_order_item => :store_order).pluck("store_orders.id").uniq).uniq.count,
            sale_quantity:             staff.store_order_items.by_month(@month).count,
            sale_amount:               staff.materials_amount_total(@month),
            task_quantity:             staff.store_staff_tasks.by_month(@month).select(:store_order_item_id).uniq.count,
            task_amount:               0,
            trade_amount:              staff.store_order_items.by_month(@month).map(&:amount).sum,
            commission_amount:         staff.store_order_items.by_month(@month).map(&:commission).sum + staff.store_staff_tasks.by_month(@month).map(&:commission).sum
          }
        when JobType::TYPES_ID['销售']
          commission_info = {
            order_quantity:            staff.store_orders.by_month(@month).count,
            sale_quantity:             staff.store_order_items.by_month(@month).count,
            sale_amount:               staff.materials_amount_total(@month),
            task_quantity:             0,
            task_amount:               0,
            trade_amount:              staff.store_orders.by_month(@month).map(&:amount).sum,
            commission_amount:         staff.store_order_items.by_month(@month).map(&:commission).sum
          }
        else
          commission_info = {
            order_quantity:     0,
            sale_quantity:      0,
            sale_amount:        0,
            task_quantity:      0,
            task_amount:        0,
            trade_amount:       0,
            commission_amount:  0
          }
        end
      end
      @performances << basic_info.merge(commission_info)
    end
  end
end
