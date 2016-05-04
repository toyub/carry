module Notifications
  class CalendarScheduleReminder < Notification
    def self.send_message(content, receiver)
      CreateNotificationService.call(self, content, receiver)
    end
  end
end
