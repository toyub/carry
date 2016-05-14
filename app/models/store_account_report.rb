class StoreAccountReport < ActiveRecord::Base
  belongs_to :store
  belongs_to :account, polymorphic: true

  scope :incomes, -> { where(type: "StoreAccountReceivableReport") }
  scope :payables, -> { where(type: "StoreAccountPayableReport") }
  scope :by_created_month, ->(month = Time.now.last_month.strftime("%Y%m")) { where(created_month: month) }
end
