class StoreCommission < ActiveRecord::Base
  include StaffBaseCommission

  belongs_to :ownerable, polymorphic: true
  has_many :store_commission_items

  def order_quantity
    store_commission_items.select(:store_order_id).uniq.count
  end

  def sale_quantity
    store_commission_items.by_type('sale').count
  end

  def sale_amount
    store_commission_items.by_type('sale').map(&:item_amount).sum
  end

  def task_quantity
    store_commission_items.by_type('constructed').count
  end

  def task_amount
    store_commission_items.by_type('sale').map(&:item_amount).sum
  end

  def trade_amount
    store_commission_items.by_type('sale').map(&:item_amount).sum
  end

  def commission_amount
    store_commission_items.map(&:commission_amount).sum
  end


end
