module Api
  module Order
    class StorePackagesController < BaseController

      def index
        # params[:q] = { name_cont: params[:name_cont] }
        @q = @store.store_packages.ransack(params[:q])
        @store_packages = @q.result
        respond_with @store_packages, location: nil
      end
    end
  end
end
