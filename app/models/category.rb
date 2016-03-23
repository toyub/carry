class Category < ActiveRecord::Base
  belongs_to :store, foreign_key: 'parent_id'

  def items_total_quantity(month = Time.now)
    order_items.joins(:store_order).by_month(month).inject(0) {|sum, item| sum += item.quantity }
  end

  def items_total_amount(month = Time.now)
    order_items.joins(:store_order).by_month(month).inject(0) {|sum, item| sum += item.amount }
  end

end
