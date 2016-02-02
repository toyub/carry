module Settings
  class Sms::MessagesController < BaseController
    def index
      if params[:start_date].present?
        @records = SmsRecord.where(created_at: params[:start_date] .. params[:end_date])
      else
        @records = SmsRecord.all
      end
    end
  end
end
