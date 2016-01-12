class Api::Sas::CustomerConsumingController < Api::BaseController
  def index
    @data = CustomerConsumingSerializer.new.data
    render json: @data
  end
end
