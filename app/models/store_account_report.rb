class StoreAccountReport < ActiveRecord::Base
  belongs_to :store
  belongs_to :account, polymorphic: true

  scope :incomes, -> { where(type: "StoreAccountReceivableReport") }
end
