class StoreStaffTask < ActiveRecord::Base
  include BaseModel

  belongs_to :store_staff
  belongs_to :taskable, polymorphic: true

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }
end
