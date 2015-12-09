module Settings
  class Sms::SwitchesController < BaseController
    def index
      SmsNotifySwitchType.collection.map{|opt| current_store.sms_notify_switches.find_or_create_by(switch_type_id: opt.id)}
      SmsTrackingSwitchType.collection.map{|opt| current_store.sms_tracking_switches.find_or_create_by(switch_type_id: opt.id)}
      SmsCaptchaSwitchType.collection.map{|opt| current_store.sms_captcha_switches.find_or_create_by(switch_type_id: opt.id)}
    end

    def update

    end
  end
end
