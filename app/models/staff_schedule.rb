class StaffSchedule < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_date, ->(date = Date.today) { where(start_time: date.beginning_of_day..date.end_of_day) }

  def next
    self.class.where("id > ?", id).first
  end

  def prev
    self.class.where("id < ?", id).last
  end
end
