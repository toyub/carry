module Api
  module Home

    class StaffShortcutsController < BaseController
      before_action :get_works, only:[:update]
      def update
        staff = current_user.update!(home_shortcuts: params[:value])
        render json: {msg: '添加成功！', my_works: current_user.home_shortcuts, works: @works}
      end

      def destroy
        work_idx = current_user.home_shortcuts - ([] << params[:id])
        current_user.update!(home_shortcuts: work_idx)
        render json: {msg: '删除成功!'}
      end

      private
      def get_works
        @works = []
        works = (YAML.load_file Rails.root.join("config", "my_work.yml")).with_indifferent_access[:works]
        works.each do |root_category|
          root_category[:sub_categories].each do |work|
            @works << work
          end
        end
        @works
      end

    end

  end
end
