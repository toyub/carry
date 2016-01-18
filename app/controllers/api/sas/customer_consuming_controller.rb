class Api::Sas::CustomerConsumingController < Api::BaseController
  def index
    render json: Sas::CustomerConsumingDistribute.new(current_store)
  end
end
