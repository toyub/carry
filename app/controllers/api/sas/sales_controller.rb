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
    @data = StoreMonthConsumingPaymentsSerializer.new.data
    render json: @data
  end

  def categories
    @data = StoreMonthConsumingCategoriesSerializer.new.data
    render json: @data
  end

end
