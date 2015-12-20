class StoreOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :orderable, polymorphic: true
  belongs_to :store_order
  belongs_to :store_customer

  before_save :cal_amount
  before_create :set_store_info

  private

    def cal_amount
      self.amount = price * quantity
    end

    def set_store_info
      self.store_id = store_order.id
      self.store_chain_id = store_order.store_chain.id
      self.store_staff_id = store_order.creator.id
    end
end
