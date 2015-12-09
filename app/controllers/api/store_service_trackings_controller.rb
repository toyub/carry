module Api
  class StoreServiceTrackingsController < BaseController
    before_action :set_service
    before_action :set_tracking, only: [:update, :destroy]

    def update
      @tracking.update(append_store_attrs tracking_params)
      respond_with @tracking, location: nil
    end

    def create
      @tracking = @service.trackings.create(append_store_attrs tracking_params)
      respond_with @tracking, location: nil
    end

    def destroy
      @tracking.destroy
      respond_with @tracking, location: nil
    end

    private

      def set_service
        @service = current_store.store_services.find(params[:store_service_id])
      end

      def set_tracking
        @tracking = @service.trackings.find(params[:id])
      end

      def tracking_params
        params.require(:store_service_tracking).permit(:content, :mode, :delay_interval, :delay_unit, :notice_required, :trigger_timing)
      end
  end
end
