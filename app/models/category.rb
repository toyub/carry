class Category < ActiveRecord::Base

  def items_total_quantity
    order_items.inject(0) {|sum, item| sum += item.quantity }
  end

  def items_total_amount
    order_items.inject(0) {|sum, item| sum += item.amount }
  end

end
