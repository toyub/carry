class Api::Sas::ConsumingWeekController < Api::BaseController
  def index
    render json: ConsumingWeek.new(current_store)
  end
end
