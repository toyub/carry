module Api
  module Home
    class ShortcutsController < BaseController
      before_action :get_works, only: [:index]
      def index
        render json: {works: @works, my_works: current_user.home_shortcuts}
      end

      private
      def get_works
        @works = Menu.candidate_shortcuts_for_staff(current_user)
      end
    end
  end
end
