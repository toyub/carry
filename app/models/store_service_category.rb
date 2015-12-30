class StoreServiceCategory < ActiveRecord::Base
  include BaseModel

  validates :name, presence: true
  validates :name, uniqueness: { scope: :store_id }

  has_many :store_services

end
