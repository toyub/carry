class StoreCommissionItem < ActiveRecord::Base
  belongs_to :ownerable, polymorphic: true

  scope :by_month, ->(month = Time.now) { where(created_at: month.at_beginning_of_month .. month.at_end_of_month) }
  scope :by_type, ->(type) { where(commission_type: [type, 'all']) }

end
