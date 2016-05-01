module Notifications
  class TrackingReminder < Notification
    def self.send_message(content, receiver)
      CreateNotificationService.call(self, content, receiver)
    end
  end
end