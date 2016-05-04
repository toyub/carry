class CreateNotificationService

  include Serviceable

  def initialize(klass, content, receivers, sender=nil)
    @klass = klass
    @content = content.to_s.strip
    if receivers.respond_to?(:each)
      @receivers = receivers
    else
      @receivers = [receivers]
    end
    @sender = sender || SystemNotificationCreator.get_notification_creator
  end

  def call
    if @content.blank?
      return false
    end

    if @receivers.blank?
      return false
    end

    ActiveRecord::Base.transaction do
      notification = @klass.create(content: @content, creator: @sender)
      @receivers.each do |receiver|
        Envelope.create(message: notification, receiver: receiver, sender: @sender)
      end
    end
  end
end