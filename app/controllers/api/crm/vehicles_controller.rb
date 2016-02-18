module Api
  module Crm
    class VehiclesController < Api::BaseController
      def index
      end

      def update
        render json: params
      end
    end
  end
end
