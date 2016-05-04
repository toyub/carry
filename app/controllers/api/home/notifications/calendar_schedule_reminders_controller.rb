module Api
  module Home
    module Notifications
      class CalendarScheduleRemindersController < BaseController
        def index
          messages = current_staff.receiving_letters.calendar_schedule_reminders.pending.all
          respond_with messages.map{|msg|
            HomeNotificationSerializer.new(msg).as_json(root:nil)
          }
        end
      end
    end
  end
end
