class StoreOvertime < StoreEvent
  belongs_to :store_staff
  scope :amount, ->(month = Time.now.strftime("%Y%m")) {where(created_month: month) }

  def self.total
    amount.inject(0) { |sum, overwork| sum + overwork.operate["amount"].to_f }
  end
end
