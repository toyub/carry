module Api
  module Home
    class SchedulesController < BaseController
      before_action :reset_date, only: :create

      def index
        @schedules = current_user.schedules
      end

      def create
        @schedules = current_user.schedules
        @schedules.create!(schedule_param)
      end

      private
      def schedule_param
        params.require(:schedule).permit(:title, :start_time, :end_time, :remark)
      end

      def reset_date
        params[:schedule][:start_time] = DateTime.parse(params[:schedule_date] + ' ' + params[:schedule][:start_time]) if params[:schedule][:start_time].present?
        params[:schedule][:end_time] = DateTime.parse(params[:schedule_date] + ' ' + params[:schedule][:end_time]) if params[:schedule][:end_time].present?
      end
    end
  end
end
