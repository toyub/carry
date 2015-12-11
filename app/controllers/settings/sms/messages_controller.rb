module Settings
  class Sms::MessagesController < BaseController
    def index
      p params
      @topups = 5.times
    end
  end
end
