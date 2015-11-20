class StorePosition < ActiveRecord::Base
  include BaseModel
  belongs_to :store_department
  validates_presence_of :name
  validates_presence_of :store_department_id
  validates :store_department, presence: true
end
