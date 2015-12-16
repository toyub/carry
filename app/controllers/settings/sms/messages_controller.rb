module Settings
  class Sms::MessagesController < BaseController
    def index
      @topups = 5.times
      @sms_balance = current_store.sms_balance
    end
  end
end
