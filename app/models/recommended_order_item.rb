class RecommendedOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :itemable, polymorphic: true
  belongs_to :recommended_order
  before_save :cal_amount

  private
    def cal_amount
      self.amount = price * quantity
    end
end
