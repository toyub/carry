class StorePosition < ActiveRecord::Base
  include BaseModel
  belongs_to :store_department
  has_many :store_staff
  
  validates_presence_of :name
  validates_presence_of :store_department_id
  validates :store_department, presence: true
end
