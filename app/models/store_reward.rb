class StoreReward < StoreEvent
  belongs_to :store_staff
  scope :amount, ->(month = Time.now.strftime("%Y%m")) {where(created_month: month) }

  def self.total
    all.inject(0) { |sum, reword| sum + reword.operate["amount"].to_f }
  end
end
