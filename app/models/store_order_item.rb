class StoreOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :orderable, polymorphic: true
  belongs_to :store_order
  belongs_to :store_customer

  def mechanics
    ['王晓勇', '李明亮']
  end

  def youhui
    rand(10)
  end
end
