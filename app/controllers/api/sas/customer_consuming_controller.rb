class Api::Sas::CustomerConsumingController < Api::BaseController
  def index
    store = Store.find_by_id(params[:store_id]) || current_store
    @data = CustomerConsumingSerializer.new(store).data
    render json: @data
  end
end
