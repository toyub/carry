module Api
  class StoreCommissionTemplatesController < BaseController
    def show
      ct = StoreCommissionTemplate.find(params[:id])
      respond_with ct, location: nil
    end
  end
end
