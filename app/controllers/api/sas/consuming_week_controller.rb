class Api::Sas::ConsumingWeekController < Api::BaseController
  def index
    render json: Sas::ConsumingWeek.new(current_store)
  end
end
