class StoreRepayment < ActiveRecord::Base
  include BaseModel

  has_many :store_order_repayments
  has_many :store_orders, through: :store_order_repayments

  scope :by_month, ->(m = Time.now) { where(created_at: m.beginning_of_month .. m.end_of_month ) }

  def order_repayment
    self.store_order_repayments.last
  end

  def order_repayment_remaining

  end
end
