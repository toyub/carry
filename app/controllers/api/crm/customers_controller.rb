module Api
  module Crm
    class CustomersController < Api::BaseController
      def create
        render json: params
      end
    end
  end
end