class StoreAttendence < StoreEvent
  belongs_to :store_staff
  scope :amount, ->(month = Time.now.strftime("%Y%m")) {where(created_month: month) }

  def self.total
    amount.inject(0) { |sum, atttendence| sum + atttendence.operate["amount"].to_f }
  end
end
