class NotifyCalendarScheduleJob < ActiveJob::Base
  queue_as :default

  def perform(schedule)
    if schedule.blank?
      return {success: false, notice: "错误: 未发现该日程"}
    end
    if schedule.finished
      content = "您有一个日程安排: #{schedule.title}"
      Notifications::CalendarScheduleReminder.send_message(content, schedule.store_staff)
    end
  end
end
