module Api
  class StorePackageTrackingsController < BaseController
    before_action :set_package
    before_action :set_tracking, except: [:create]

    def create
      @tracking = @package.trackings.create(append_store_attrs tracking_params)
      respond_with @tracking, location: nil
    end

    def update
      @tracking.update(append_store_attrs tracking_params)
      respond_with @tracking, location: nil
    end

    def destroy
      @tracking.destroy
      respond_with @tracking, location: nil
    end

    private

      def set_package
        @package = current_store.store_packages.find(params[:store_package_id])
      end

      def set_tracking
        @tracking = @package.trackings.find(params[:id])
      end

      def tracking_params
        params.require(:store_package_tracking).permit(:content, :mode, :delay_interval, :delay_unit, :notice_required, :trigger_timing)
      end
  end
end
