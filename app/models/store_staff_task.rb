class StoreStaffTask < ActiveRecord::Base
  include BaseModel

  belongs_to :store_staff
  belongs_to :taskable, polymorphic: true
end
