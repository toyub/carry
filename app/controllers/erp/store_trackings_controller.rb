module Erp
  class StoreTrackingsController < BaseController
    def index
      @trackings = StoreTracking.all
      respond_with @trackings, location: nil
    end
  end
end
