module Api
  class StoreCheckoutsController < BaseController

    def create
      
      render json: params
    end

  end
end