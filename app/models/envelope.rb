class Envelope < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  belongs_to :message, polymorphic: true, counter_cache: true, dependent: :destroy

  before_create :set_extra_type

  scope :work_reminders, ->{where(extra_type: Notifications::WorkReminder.name)}
  scope :system_bulletins, ->{where(extra_type: Notifications::SystemBulletin.name)}
  scope :tracking_reminders, ->{where(extra_type: Notifications::TrackingReminder.name)}
  scope :calendar_schedule_reminders, ->{where(extra_type: Notifications::CalendarScheduleReminder.name)}

  enum status: %i[ pending open deleted ]

  def extra_type_name
    I18n.t extra_type.to_s.underscore, scope: [:activerecord, :models]
  end

  def sender_name
    sender.full_name
  end

  def receiver_name
    receiver.full_name
  end

  def message_content
    message.content
  end

  def status_i18n
    I18n.t status, scope: [:enums, :envelope, :status]
  end

  private
  def set_extra_type
    self.extra_type = self.message.class.name
  end
end
