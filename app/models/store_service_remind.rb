class StoreServiceRemind < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service

  TIMING = { 1 => "开单后", 2 => "技师上岗后", 3 => "施工结束后" }

end
