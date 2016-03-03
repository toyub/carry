class StaffSaleCommissionJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StoreStaff.all.each do |staff|
      staff.sale_histories.create!(sale_params(staff))
    end
  end

  private
  def sale_params(staff)
    sale_history = ActionController::Parameters.new(
      store_id: staff.store.id,
      store_chain_id: staff.store_chain.id,
      order_quantity: staff.store_orders.by_month.count,
      order_amount: staff.store_orders.by_month.map(&:amount).sum,
      item_quantity: staff.store_order_items.by_month.count,
      item_amount: staff.store_order_items.by_month.map(&:amount).sum,
      material_quantity: staff.store_order_items.by_month.materials.count,
      material_amount: staff.store_order_items.by_month.materials.map(&:amount).sum,
      service_quantity: staff.store_order_items.by_month.services.count,
      service_amount: staff.store_order_items.by_month.services.map(&:amount).sum,
      package_quantity: staff.store_order_items.by_month.packages.count,
      package_amount: staff.store_order_items.by_month.packages.map(&:amount).sum,
      task_quantity: staff.job_type_id == JobType::TYPES_ID['技师'] ? staff.tasks.by_month : 0,
      commission_amount: staff.commission? ? staff.commission_amount_total : 0.0,
      created_month: Time.now.strftime("%Y%m")
    )
    sale_history.permit(:store_id, :store_chain_id, :order_quantity, :order_amount, :item_quantity, 
                        :item_amount, :material_quantity, :material_amount, :service_quantity, 
                        :service_amount, :package_quantity, :package_amount, :task_quantity, 
                        :commission_amount, :created_month)
  end
end
