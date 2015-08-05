class StoreServiceCategory < ActiveRecord::Base
  include BaseModel

  validates :name, presence: true
  validates :name, uniqueness: { scope: :store_id }

end
