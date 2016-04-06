class StoreCommission < ActiveRecord::Base

  belongs_to :ownerable, polymorphic: true
  has_many :store_commission_items

  def commission
    {
      id:                        ownerable.id,
      name:                      ownerable.screen_name,
      numero:                    ownerable.numero,
      department:                ownerable.store_department.try(:name),
      position:                  ownerable.store_position.try(:name),
      order_quantity:            order_quantity,
      sale_quantity:             sale_quantity,
      sale_amount:               sale_amount,
      task_quantity:             task_quantity,
      task_amount:               task_amount,
      trade_amount:              trade_amount,
      commission_amount:         commission_amount
    }
  end

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
