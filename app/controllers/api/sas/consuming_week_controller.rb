class Api::Sas::ConsumingWeekController < Api::BaseController
  def index
    store = Store.find_by_id(params[:store_id]) || current_store
    @data = ConsumingWeekSerializer.new(store).data
    render json: @data
  end
end
