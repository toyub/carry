module Api
  class StoreServiceRemindsController < BaseController
    before_action :set_service, :set_remind

    def update
      @remind.update(append_store_attrs remind_params)
      respond_with @remind, loction: nil
    end

    private

      def set_service
        @service = current_store.store_services.find(params[:store_service_id])
      end

      def set_remind
        @remind = @service.reminds.find(params[:id])
      end

      def remind_params
        params.require(:store_service_remind).permit(:content, :mode, :delay_interval, :enable, :notice_required, :trigger_timing)
      end
  end
end
