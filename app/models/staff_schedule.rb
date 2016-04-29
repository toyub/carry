class StaffSchedule < ActiveRecord::Base
  belongs_to :store_staff

  def next
    self.class.where("id > ?", id).first
  end

  def prev
    self.class.where("id < ?", id).last
  end
end
