class StoreStaffTask < ActiveRecord::Base
  include BaseModel

  belongs_to :store_staff
  belongs_to :store_order_item
  belongs_to :mechanic, class_name: 'StoreStaff', foreign_key: :mechanic_id
  belongs_to :taskable, polymorphic: true

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }

  def free
    self.mechanic.store_group_member.free!
  end
end
