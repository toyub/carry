class StoreGroup < ActiveRecord::Base
  include BaseModel
  has_many :store_group_members
  has_many :members, class_name: 'StoreStaff', through: :store_group_members
  has_many :workstations, class_name: 'StoreWorkstation'
  scope :actived, ->{where(deleted: false)}

  def soft_delete!
    if self.store_group_members.present?
      errors.add(:store_group_members, '删除小组前请先移除所有小组成员')
    else
      self.update!(deleted: true)
    end
  end
end
