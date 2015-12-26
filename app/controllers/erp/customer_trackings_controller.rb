module Erp
  class CustomerTrackingsController < BaseController
    def index
      @q = StoreTracking.ransack(params[:q])
      @trackings = @q.result(distince: true)
      respond_with @trackings, location: nil
    end
  end
end
