class StoreGroupMember < ActiveRecord::Base
  include BaseModel
  belongs_to :store_group
  belongs_to :member, class_name: 'StoreStaff', foreign_key: 'member_id'
  enum work_status: %i[absence ready busy]
end
