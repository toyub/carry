class Category < ActiveRecord::Base

  def items_total_quantity(month = Time.now)
    order_items.by_month(month).inject(0) {|sum, item| sum += item.quantity }
  end

  def items_total_amount(month = Time.now)
    order_items.by_month(month).inject(0) {|sum, item| sum += item.amount }
  end

end
