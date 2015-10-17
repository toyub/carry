class StoreMaterialOrderPayment < ActiveRecord::Base
  include BaseModel
  belongs_to :store_settlement_account
  belongs_to :store_material_order

  before_save :set_order_balance

  private
  def set_order_balance
    self.order_balance = self.store_material_order.amount - self.amount
  end
end
