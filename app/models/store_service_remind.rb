class StoreServiceRemind < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service

  enum mode: [:sms, :wechat]
  enum trigger_timing: [:ordered, :started, :finished]

  def mode_i18n
    I18n.t "enums.store_service_remind.mode.#{self.mode}"
  end

  def trigger_timing_i18n
    I18n.t "enums.store_service_remind.trigger_timing.#{self.trigger_timing}"
  end

  def sms_enabled?
    self.enable? && self.sms?
  end

  def message
    content
  end

end
