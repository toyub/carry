class Api::Sas::ConsumingWeekController < Api::BaseController
  def index
    @data = ConsumingWeekSerializer.new(current_store).data
    render json: @data
  end
end
