module Api
  module Home

    class StoreStaffController < BaseController
      before_action :get_works, only:[:update]
      def update
        staff = current_user.update!(works: params[:value])
        render json: {msg: '添加成功！', my_works: current_user.works, works: @works}
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
