class StoreStaffCommissionHistory < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }
  scope :by_type, ->(type) { where(commission_type: [type, 'all']) }

end
