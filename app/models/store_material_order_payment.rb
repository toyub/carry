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

# == Schema Information
#
# Table name: store_material_order_payments
#
#  id                          :integer          not null, primary key
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_supplier_id           :integer          not null
#  store_material_order_id     :integer          not null
#  store_settlement_account_id :integer          not null
#  amount                      :decimal(10, 2)
#  order_balance               :decimal(10, 2)
#  created_at                  :datetime
#  updated_at                  :datetime
#
