class SystemNotificationCreator < SystemNarrator
  def self.get_notification_creator
    self.find_or_create_by(extra_id: SYSTEM_NOTIFICATION_CREATOR)
  end
end
