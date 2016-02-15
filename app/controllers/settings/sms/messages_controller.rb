module Settings
  class Sms::MessagesController < BaseController
    def index
      @records = SmsRecord.all
      if params[:start_date].present?
        @records = SmsRecord.where(created_at: params[:start_date] .. params[:end_date])
      elsif params[:category].present?
        first_category, second_category = params[:category].split("-")
        @records = @records.where(first_category: first_category).where(second_category: second_category)
      end

    end
  end
end
