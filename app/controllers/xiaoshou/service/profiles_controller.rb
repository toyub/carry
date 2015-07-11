module Xiaoshou
  module Service
    class ProfilesController < Xiaoshou::BaseController
      before_action :load_store

      def index
        @services = @store.store_services
      end

      def new
        @services = @store.store_services
        @service = @store.store_services.new
      end

      def create
        @services = @store.store_services
        @service = @store.store_services.build(profile_params)
        if @service.save
          redirect_to [:new, :xiaoshou, :service, :setting]
        else
          render :new
        end
      end

      private
      def load_store
        @store = current_user.store
      end

      def profile_params
        params.require(:store_service).permit(
          :name, :code, :retail_price,
          :bargain_price, :point,
          :introduction, :remark,
          :store_service_category_id, :favorable
        )
      end
    end
  end
end
