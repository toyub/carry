class Api::Sas::ConsumingWeekController < Api::BaseController
  def index
    @data = ConsumingWeekSerializer.new.data
    render json: @data
  end
end
