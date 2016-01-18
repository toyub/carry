class Api::Sas::CustomerConsumingController < Api::BaseController
  def index
    render json: CustomerConsumingDistribute.new(current_store)
  end
end
