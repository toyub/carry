class Api::Sas::CustomerConsumingController < Api::BaseController
  def index
    @data = CustomerConsumingSerializer.new(current_store).data
    render json: @data
  end
end
