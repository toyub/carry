module Api
  module Home
    class MyWorksController < BaseController
      before_action :get_works, only: [:index]
      def index
        render json: {works: @works, my_works: current_user.works}
      end

      private
      def get_works
        @works = current_user.work_list
      end
    end
  end
end
