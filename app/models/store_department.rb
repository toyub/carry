class StoreDepartment < ActiveRecord::Base
  include BaseModel
  has_many :store_positions
  validates_presence_of :name

end
