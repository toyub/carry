module Api
  class StorePackagesController < BaseController
    before_action :set_package, only: [:save_picture]

    def create
      @package = current_store.store_packages.create(append_store_attrs package_params)
      respond_with @package, location: nil
    end

    def save_picture
      @package.uploads.create(append_store_attrs img_params)
      respond_with @package, location: nil
    end

    private

      def set_package
        @package = current_store.store_packages.find(params[:id])
      end

      def package_params
        params.require(:store_package).permit(:name, :code, :abstract, :remark)
      end

      def img_params
        params.permit(:img)
      end
  end
end
