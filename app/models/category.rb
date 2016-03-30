class Category < ActiveRecord::Base

  def items_total_quantity(store, month = Time.now)
    order_items.joins(:store_order).where(store_id: store.id).by_month(month).map(&:quantity).sum
  end

  def items_total_amount(store, month = Time.now)
    order_items.joins(:store_order).where(store_id: store.id).by_month(month).map(&:amount).sum
  end

end
