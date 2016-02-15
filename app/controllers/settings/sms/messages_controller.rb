module Settings
  class Sms::MessagesController < BaseController

    def index
      @records = current_store.sms_records
      if params[:start_date].present?
        @records = @records.by_date(params[:start_date], params[:end_date])
      end
      if params[:category].present?
        first_category, second_category = params[:category].split("-")
        @records = @records.by_category(first_category, second_category)
      end

    end
  end
end
