class StoreStaffSaleHistory < ActiveRecord::Base
  include BaseModel

  belongs_to :store_staff
end
