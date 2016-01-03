class StoreGroup < ActiveRecord::Base
  include BaseModel
  has_many :store_group_members
  has_many :members, class_name: 'StoreStaff', through: :store_group_members
end
