class StoreOrderRepayment < ActiveRecord::Base
  belongs_to :store_order
  belongs_to :store_repayment
end
