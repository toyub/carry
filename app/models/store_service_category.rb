class StoreServiceCategory < ActiveRecord::Base
  include BaseModel

  validates :name, presence: true
  validates :name, uniqueness: { scope: :store_id }

  has_many :store_services
  has_many :order_items, through: :store_services, source: :store_order_items

  def items_total_quantity
    order_items.inject(0) {|sum, item| sum += item.quantity }
  end

  def items_total_amount
    order_items.inject(0) {|sum, item| sum += item.amount }
  end

end
