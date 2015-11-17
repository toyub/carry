class StoreSettlementAccount < ActiveRecord::Base
  include BaseModel

  enum status: [:active, :inactive]
end
