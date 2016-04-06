class StaffBaseCommission
  def initialize(staff, month)
    @staff = staff
    @month = month
    staff_order_items
  end

  def commission
    {

      id:                        @staff.id,
      name:                      @staff.screen_name,
      numero:                    @staff.numero,
      department:                @staff.store_department.try(:name),
      position:                  @staff.store_position.try(:name),
      order_quantity:            order_quantity,
      sale_quantity:             sale_quantity,
      sale_amount:               sale_amount,
      task_quantity:             task_quantity,
      task_amount:               task_amount,
      trade_amount:              trade_amount,
      commission_amount:         commission_amount
    }
  end

  private
  def staff_order_items
    @tasks = @staff.store_staff_tasks.by_month(@month)
    @order_items = @staff.store_order_items.except_from_customer_assets.by_month(@month)
    if @staff.current_month_regulared?
      @order_items = @order_items.where("created_at > ?", @staff.regular_protocal.effected_on)
      @tasks = @tasks.where("created_at > ?", @staff.regular_protocal.effected_on)
    end
  end

end
