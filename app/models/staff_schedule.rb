class StaffSchedule < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_date, ->(date = Date.today) { where(start_time: date.beginning_of_day..date.end_of_day) }

  def next
    self.class.by_date(self.start_time).where("id > ?", id).first
  end

  def prev
    self.class.by_date(self.start_time).where("id < ?", id).last
  end

  def remain_until
    (((self.start_time - s.created_at) / 1.hour).round - 1).hour
  end
end
