class Api::Sas::SalesController < Api::BaseController
  def index
    sales = StoreMonthConsumingSerializer.new.data
    @data = {
      months: sales.keys,
      figures: sales.values
    }

    render json: @data
  end

  def payments
  end

end
