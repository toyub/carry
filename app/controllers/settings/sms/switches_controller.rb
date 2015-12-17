module Settings
  class Sms::SwitchesController < BaseController
    def index
      @notify_switchs = SmsNotifySwitchType.collection.map{|opt| current_store.store_switches.fetch_with_switch_and_operator(opt, current_staff)}
      @tracking_switchs = SmsTrackingSwitchType.collection.map{|opt| current_store.store_switches.fetch_with_switch_and_operator(opt, current_staff)}
      @captcha_switchs = SmsCaptchaSwitchType.collection.map{|opt| current_store.store_switches.fetch_with_switch_and_operator(opt, current_staff)}
      @sms_balance = current_store.sms_balance
    end

    def update
      switch = current_store.store_switches.find(params[:id])
      switch.update(enabled: !switch.enabled)
      render json: switch
    end
  end
end
