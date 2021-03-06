class StaffSchedule < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_date, ->(date = Date.today) { where(start_time: date.beginning_of_day..date.end_of_day) }
  scope :unfinished, -> { where(finished: false) }

  def next
    self.class.by_date(self.start_time).where("id > ?", id).first
  end

  def prev
    self.class.by_date(self.start_time).where("id < ?", id).last
  end

  def remain_until
     self.start_time.to_i -  self.created_at.to_i - 1.hour
  end
end
