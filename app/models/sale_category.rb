class SaleCategory < Category

  has_many :store_material_saleinfos
  has_many :order_items, through: :store_material_saleinfos, source: :store_order_items

  def items_total_quantity
    order_items.inject(0) {|sum, item| sum += item.quantity }
  end

  def items_total_amount
    order_items.inject(0) {|sum, item| sum += item.amount }
  end

end
