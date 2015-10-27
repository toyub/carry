class StoreSettlementAccount < ActiveRecord::Base
  include BaseModel

  enum status: [:active, :inactive]
end

# == Schema Information
#
# Table name: store_settlement_accounts
#
#  id               :integer          not null, primary key
#  store_id         :integer          not null
#  store_chain_id   :integer          not null
#  store_staff_id   :integer          not null
#  name             :string(45)
#  bank_name        :string(200)
#  bank_card_number :string(100)
#  status           :integer          default(0), not null
#  remark           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
