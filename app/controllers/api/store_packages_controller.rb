module Api
  class StorePackagesController < BaseController
    include Uploadable

    before_action :set_package, except: [:create]

    def create
      @package = current_store.store_packages.create(append_store_attrs package_params)
      respond_with @package, location: nil
    end

    def update
      @package.update(append_store_attrs package_params)
      respond_with @package, location: nil
    end

    private
      def resource
        @package ||= set_package
      end

      def set_package
        @package = current_store.store_packages.find(params[:id])
      end

      def package_params
        params.require(:store_package).permit(:name, :code, :abstract, :remark)
      end
  end
end
