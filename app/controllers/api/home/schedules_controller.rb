module Api
  module Home
    class SchedulesController < BaseController
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
    end
  end
end
