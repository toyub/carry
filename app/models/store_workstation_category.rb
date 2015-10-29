class StoreWorkstationCategory < ActiveRecord::Base
  include BaseModel

  has_many :workstations, class_name: 'StoreWorkstation'

  validates :name, presence: true
  validates :name, uniqueness: {scope: :store_id}
end
