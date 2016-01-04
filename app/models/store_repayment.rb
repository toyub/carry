class StoreRepayment < ActiveRecord::Base
  include BaseModel

  has_many :store_order_repayments
  has_many :store_orders, through: :store_order_repayments
end
