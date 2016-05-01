class SystemNarrator < ActiveRecord::Base
  SYSTEM_NOTIFICATION_CREATOR = 1

  def name
    '系统'
  end
end
