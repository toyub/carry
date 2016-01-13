module Erp
  class ContactWaysController < BaseController
    def index
      @contact_ways = StoreTracking::CONTACT_WAY
      respond_with @contact_ways, location: nil
    end
  end
end
