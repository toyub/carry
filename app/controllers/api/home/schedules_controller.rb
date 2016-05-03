module Api
  module Home
    class SchedulesController < BaseController
      before_action :reset_date, only: :create

      def index
        @schedules = current_user.schedules
      end

      def search
        @schedules = current_user.schedules.by_date((Date.parse(params[:date]) if params[:date].present?) )
      end

      def show
        @schedule = current_user.schedules.find(params[:id])
      end

      def create
        @schedules = current_user.schedules
        schedule = @schedules.create!(schedule_param)
        if schedule.remain_until <= 0
          NotifyCalendarScheduleJob.perform_later schedule
        else
          NotifyCalendarScheduleJob.set(wait: schedule.remain_until).perform_later schedule
        end
      end

      private
      def schedule_param
        params.require(:schedule).permit(:title, :start_time, :end_time, :remark)
      end

      def reset_date
        if params[:schedule][:start_time].present?
          params[:schedule][:start_time] = DateTime.parse(params[:schedule_date] + ' ' + params[:schedule][:start_time] + "#{Time.zone}")
        end
        if params[:schedule][:end_time].present?
          params[:schedule][:end_time] = DateTime.parse(params[:schedule_date] + ' ' + params[:schedule][:end_time] + "#{Time.zone}")
        end
      end
    end
  end
end
